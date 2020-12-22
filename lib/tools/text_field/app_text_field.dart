
import 'package:flutter/material.dart';
import '../../public_header.dart';

enum TexFieldMode{
  oneMode,
  twoMode,
  threeMode
}

class AppTextField extends StatefulWidget {

  const AppTextField({
    Key key,
    @required this.controller,
    @required this.hintText,
    @required this.focusNode,
    this.maxLength = 19,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    this.showPass = false,
    this.keyName,
    this.leftImage,
    this.mode = TexFieldMode.oneMode,
    this.height = 45.0,
    this.allowChinese = false,
    this.isTap = true,
    this.radius = 25.0,
    this.showDelete = false,
    this.edgeInsets,
    this.onSubmit
  }): super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final bool isTap;
  final TextInputType keyboardType;
  final String hintText;
  final String leftImage;
  final FocusNode focusNode;
  final bool showPass;
  /// 用于集成测试寻找widget
  final String keyName;
  final TexFieldMode mode;
  final bool allowChinese;
  final double height;
  final double radius;
  final bool showDelete;
  final EdgeInsets edgeInsets;
  final Function onSubmit;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {

  bool _isShowPwd = true;
  bool _isShowDelete = false;

  @override
  void initState() {
    super.initState();

    _isShowPwd = widget.showPass;
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

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(isEmpty);
  }

  @override
  Widget build(BuildContext context) {

    ThemeData themeData = Theme.of(context);
    bool isDark = themeData.brightness == Brightness.dark;
    switch(widget.mode){
      case TexFieldMode.oneMode:
        {
          return createOneModel(isDark, themeData);
        }
        break;
      case TexFieldMode.twoMode:
        {
          return createTwoLineModel(isDark, themeData);
        }
        break;
      case TexFieldMode.threeMode:
        {
          return createThreeModel(isDark, themeData);
        }
        break;
      default:{}break;
    }
  }

  ///模式1
  createOneModel(bool isDark, ThemeData themeData){
    return Container(
      height: widget.height,
      padding: widget.edgeInsets??EdgeInsets.only(left: 16,right: 16),
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
          clearBtn(),
          !widget.showPass ? Gaps.empty : Gaps.hGap15,
          showEyes(),
        ],
      ),
    );
  }

  ///模式2
  createTwoLineModel(bool isDark, ThemeData themeData){
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(left: 16,right: 16),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.black33Color,width: 1))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          leftImage(),
          centerRadiusTextField(),
          clearBtn(),
          !widget.showPass ? Gaps.empty : Gaps.hGap15,
          showEyes(),
        ],
      ),
    );
  }

  ///模式3
  createThreeModel(bool isDark, ThemeData themeData){
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(left: 16,right: 16),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.lineColor,width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: AppColors.whiteColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          leftImage(),
          centerRadiusTextField(),
          clearBtn(),
          !widget.showPass ? Gaps.empty : Gaps.hGap15,
          showEyes(),
        ],
      ),
    );
  }


  //左侧图片
  leftImage(){
    return  widget.leftImage==null?SizedBox():Container(
      width: 30,
      child: Center(child: LoadAssetImage(widget.leftImage,width: 20,height: 20,)),
    );
  }
  //中间输入框
  centerRadiusTextField(){

    return widget.allowChinese?Expanded(
        child: TextField(
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          obscureText: _isShowPwd,
          autofocus: widget.autoFocus,
          controller: widget.controller,
          enabled: widget.isTap,
          textInputAction: TextInputAction.done,
          keyboardType: widget.keyboardType,
          onSubmitted: (value){
            widget.onSubmit();
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: AppColors.black54Color),
            counterText: '',
            border: new OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        )
    ):Expanded(
        child: TextField(
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          autofocus: widget.autoFocus,
          controller: widget.controller,
          obscureText: _isShowPwd,
          enabled: widget.isTap,
          onSubmitted: (value){
            widget.onSubmit();
          },
          textInputAction: TextInputAction.done,
          keyboardType: widget.keyboardType??TextInputType.text,
          // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
          inputFormatters: (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone) ?
          [WhitelistingTextInputFormatter(RegExp('[0-9]'))] : [BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]'))],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: AppColors.black54Color),
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

  //密文
  showEyes(){

    return !widget.showPass ? Gaps.empty : Semantics(
      label: '密码可见开关',
      hint: '密码是否可见',
      child: GestureDetector(
        child:_isShowPwd==false ? Icon(Icons.remove_red_eye,size: 22,) :LoadAssetImage(
          '不可见',
          key: Key('${widget.keyName}_showPwd'),
          width: 18.0,
          height: 18.0,
        ),
        onTap: () {
          setState(() {
            _isShowPwd = !_isShowPwd;
          });
        },
      ),
    );
  }
}
