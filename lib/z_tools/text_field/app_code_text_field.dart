
import 'package:demo/z_tools/net/md5.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

enum TextFieldMode{
  lineMode,//下划线
  radiusMode,//圆角
  radiusLineMode//圆角边线
}

class AppCodeTextField extends StatefulWidget {

  final TextEditingController controller;
  final TextEditingController controllerPhone; //手机号码
  final bool autoFocus;
  final int maxLength;
  final bool isTap;
  final String leftImage;
  final FocusNode focusNode;
  final Function reloadCode;
  final bool showDelete;
  final String hintText;
  /// 用于集成测试寻找widget
  final String keyName;
  final TextFieldMode mode;
  final double height;
  final String type; //类型 1.注册、2.忘记密码、2.验证码登录
  final double radius;
  final Color bgColor;
  final EdgeInsets edgeInsets;

  const AppCodeTextField({
    Key key,
    @required this.controller,
    @required this.controllerPhone,
    this.type,
    this.autoFocus = false,
    this.isTap,
    this.leftImage,
    this.focusNode,
    this.reloadCode,
    this.keyName,
    this.mode = TextFieldMode.radiusMode,
    this.height = 45.0,
    this.showDelete = false,
    this.maxLength = 6,
    this.radius = 25.0,
    this.hintText = '请输入验证码',
    this.bgColor,
    this.edgeInsets = const EdgeInsets.only(left: 16,right: 16),
  }) : super(key: key);

  @override
  _AppCodeTextFieldState createState() => _AppCodeTextFieldState();
}

class _AppCodeTextFieldState extends State<AppCodeTextField> {


  bool _isShowDelete = false;
  //是否可以获取验证码
  bool _clickable = true;
  bool _isSuccess = false;
  /// 倒计时秒数
  int _second = 10;
  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isEmpty;
    /// 监听输入改变
    widget.controller.addListener(isEmpty);
  }

  void isEmpty() {
    bool isEmpty = widget.controller.text.isEmpty;
    /// 状态不一样在刷新，避免重复不必要的setState
    if (isEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isEmpty;
      });
    }
  }

  //验证码倒计时
  startRunCode()async{
    _second = 90;
    _subscription = Stream.periodic(Duration(seconds: 1), (i) => i).take(_second).listen((i) {
      setState(() {
        _currentSecond = _second - i - 1;
        _clickable = _currentSecond < 1;
      });
    });
  }

  //获取验证码
  getVCode(){
    if(widget.controllerPhone.text.length!=11){
//      Toast.show('请输入正确的手机号');
      return;
    }
    if(_clickable){
      debugPrint('发起获取验证码的网络请求:-------------> getCode');
      var parameters = {};
      parameters['phone'] = widget.controllerPhone.text;
      parameters['sign'] = generateMd5('subang_'+widget.controllerPhone.text);
      if(widget.type!=null){
        parameters['type'] = widget.type;
      }else{
        parameters['type'] = '2';
      }

      DioUtils.instance.post(Api.getCodeUrl,data: parameters, onFailure: (code,msg){
        Toast.show(msg);
      }, onSucceed: (result){
        startRunCode();
        Toast.show('验证码已发送,请注意接收');
      });

    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
    widget.controller?.removeListener(isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDark = themeData.brightness == Brightness.dark;
    switch(widget.mode){
      case TextFieldMode.radiusMode:
        {
          return createRadiusMode(isDark, themeData);
        }
        break;
      case TextFieldMode.lineMode:
        {
          return createLineMode(isDark, themeData);
        }
        break;
      case TextFieldMode.radiusLineMode:
        {
          return createRadiusLineMode(isDark, themeData);
        }
        break;
      default:{}break;
    }
  }

  //圆角
  createRadiusMode(bool isDark, ThemeData themeData){

    return Container(
      height: widget.height,
      padding: widget.edgeInsets,
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(widget.radius)),
          color: isDark?AppColors.dark_inputBgColor:AppColors.inputBgColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          leftImage(),
          centerRadiusTextField(),
          getCodeBtn(isDark),
        ],
      ),
    );

  }

  //下划线
  createLineMode(bool isDark, ThemeData themeData){

    return Container(
      height: widget.height,
      padding: widget.edgeInsets,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.lineColor,width: 1))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          leftImage(),
          centerRadiusTextField(),
          getCodeBtn(isDark),
        ],
      ),
    );
  }
  //下划线
  createRadiusLineMode(bool isDark, ThemeData themeData){

    return Container(
      height: widget.height,
      padding: widget.edgeInsets,
      decoration: BoxDecoration(
          border: Border.all(color:AppColors.lineColor,width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: widget.bgColor??AppColors.transparentColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          leftImage(),
          centerRadiusTextField(),
          getCodeBtn(isDark),
        ],
      ),
    );
  }

  //左侧图片
  leftImage(){
    return  widget.leftImage==null?SizedBox():Container(
      width: 30,
      child: Center(child: LoadAssetImage(widget.leftImage,width: 15,height: 15,)),
    );
  }
  //中间输入框
  centerRadiusTextField(){
    return Expanded(
        child: TextField(
          focusNode: widget.focusNode,
          maxLength: 6,
          autofocus: widget.autoFocus,
          controller: widget.controller,
          enabled: widget.isTap,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          // 数字、手机号限制格式为0到9(白名单)
          inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.black54Color),
            counterText: '',
            border: new OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        )

    );
  }
  //清空输入框
  clearBtn(){
    return widget.showDelete?FlatButton(
        onPressed: (){
          widget.controller.text = '';
        },
        child: Container(
          width: widget.height,
          height: widget.height,
          alignment: Alignment.center,
          child: Icon(Icons.cancel,size: 10,color: Colors.red,),
        )
    ):SizedBox();
  }
  //获取验证码按钮
  getCodeBtn(bool isDark){
    return Theme(
      data: Theme.of(context).copyWith(
        buttonTheme: ButtonThemeData(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: widget.height,
          minWidth: 85.0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      child: FlatButton(
        onPressed:(){
          if(_clickable){
            getVCode();
          }
        },
        textColor: AppColors.mainColor,
        color: Colors.transparent,
        child: Container(
          height: 30,
          width: 85,
          alignment: Alignment.center,
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.all(Radius.circular(8.0)),
//            color: AppColors.lightYellowColor,
//            border: Border.all(
//                width: 1,color: AppColors.black87Color
//            )
//          ),
          child: Text(
            _clickable ? '获取验证码' : '（$_currentSecond s）',
            style: TextStyle(fontSize: Dimens.font_sp12,color: AppColors.mainColor),
          ),
        ),
      ),
    );
  }


  //中间输入框
  centerLineTextField(){
    return Expanded(
        child: TextField(
          focusNode: widget.focusNode,
          maxLength: 6,
          autofocus: widget.autoFocus,
          controller: widget.controller,
          enabled: widget.isTap,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          // 数字、手机号限制格式为0到9(白名单)
          inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            hintText: '请输入验证码',
            hintStyle: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.black54Color),
            counterText: '',
            border: new OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        )

    );
  }


}

