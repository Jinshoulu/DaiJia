
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:demo/app_pages/be_user_common/AppLocal.dart';
import 'package:demo/app_pages/login/complete_info_page.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/dialog/empty_bottom_sheet.dart';
import 'package:demo/z_tools/dialog/operate_empty_dialog.dart';
import 'package:demo/z_tools/net/UploadUtils.dart';
import 'package:demo/z_tools/text_field/app_code_text_field.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../public_header.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _editingControllerPhone = new TextEditingController();
  TextEditingController _editingControllerPassword = new TextEditingController();
  TextEditingController _editingControllerCode = new TextEditingController();

  FocusNode _focusNodePhone = new FocusNode();
  FocusNode _focusNodePassword = new FocusNode();
  FocusNode _focusNodeCode = new FocusNode();

  bool isAgree = false;
  //签名图片
  String signImage;
  BuildContext _buildContext;

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
    AppLocal.getLocation().then((value){
      print(value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return KeyboardActionWidget(
        list: [_focusNodePhone,_focusNodeCode,_focusNodePassword],
        child: Scaffold(
          appBar: ShowWhiteAppBar(
            centerTitle: '注册',
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 16,right: 16),
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: <Widget>[
                  AppTextField(
                      edgeInsets: EdgeInsets.all(0.0),
                      keyName: 'phone',
                      controller: _editingControllerPhone,
                      mode: TexFieldMode.fourMode,
                      keyboardType: TextInputType.number,
                      leftImage: '登录手机',
                      hintText: '请输入手机号',
                      focusNode: _focusNodePhone
                  ),
                  AppCodeTextField(
                      keyName: 'code',
                      edgeInsets: EdgeInsets.all(0.0),
                      mode: TextFieldMode.lineMode,
                      bgColor: AppColors.transparentColor,
                      controller: _editingControllerCode,
                      controllerPhone: _editingControllerPhone,
                      leftImage: '登录验证码',
                      focusNode: _focusNodeCode
                  ),
                  AppTextField(
                      edgeInsets: EdgeInsets.all(0.0),
                      keyName: 'password',
                      controller: _editingControllerPassword,
                      mode: TexFieldMode.fourMode,
                      leftImage: '登录密码',
                      hintText: '请输入密码',
                      focusNode: _focusNodePassword
                  ),
                  SizedBox(height: 100.0,),
                  SizedBox(
                    height: 50.0,
                    child: AppButton(
                        radius: 50.0,
                        bgColor: AppColors.mainColor,
                        title: '确认',textStyle: TextStyles.whiteAnd14,
                        onPress: (){
                          showSignWidget();
                        }
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: AppButton(
                              image: isAgree?'选择选中':'选择默认',
                              imageSize: 15,
                              buttonType: ButtonType.onlyImage,
                              onPress: (){
                                  setState(() {
                                    isAgree = !isAgree;
                                  });
                              }
                          ),
                        ),
                        Expanded(child: InkWell(
                          child: RichText(
                              text: TextSpan(
                                style: TextStyles.blackAnd12,
                                children: [
                                  TextSpan(
                                      text: '阅读并同意'
                                  ),
                                  TextSpan(
                                    style: TextStyles.mainAnd12,
                                    text: '《司机服务协议》'
                                  ),
                                  TextSpan(
                                      text: '的内容'
                                  )
                                ]
                              )
                          ),
                          onTap: (){
                            AppShowBottomDialog.showDelegateDialog(context, '司机服务协议', '这是关于司机服务的协议', (){
                              setState(() {
                                isAgree = true;
                              });
                            });
                          },
                        ))
                      ],
                    ),
                  ),
                  Expanded(flex: 3,child: SizedBox()),
                ],
              ),
            ),
          ),
        )
    );
  }

  showSignWidget(){
    showModalBottomSheet(
      context: this.context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return EmptyBottomSheet(
            topWidget: TextContainer(
                showBottomSlide: true,
                slideColor: AppColors.black33Color,
                alignment: Alignment.center,
                title: '协议签名确认',
                height: 50,
                style: TextStyle(
                  fontSize: Dimens.font_sp18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor
                )
            ),
            centerWidget: Container(
              height: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Signature(
                    controller: _controller,
                    height: 150.0,
                    backgroundColor: AppColors.bgColor,
                  ),
                  Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    child: Text('您的签名会经过平台审核，如果不符合规格将不能正常接单',textAlign: TextAlign.center,style: TextStyles.blackAnd12,),
                  )
                ],
              ),
            ),
            downWidget: Container(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: AppButton(radius: 45,title: '重签',bgColor: AppColors.redBtnColor, textStyle: TextStyles.whiteAnd14,onPress: () {
                    setState(() {
                      _controller.clear();
                    });
                  })),
                  SizedBox(width: 20,),
                  Expanded(child: AppButton(radius: 45,title: '确认',bgColor: AppColors.mainColor, textStyle: TextStyles.whiteAnd14,onPress: () async{
                    Navigator.pop(context);
                    if (_controller.isNotEmpty) {
                      final Uint8List data = await _controller.toPngBytes();
                      _saveToImage(data, 'signImage');
                    }
                  }))
                ],
              ),
            )
        );
      },
    );
  }

  startRegister(){

    if(_editingControllerPhone.text.isEmpty){
      Toast.show('手机号码不能为空');
      return;
    }
    if(_editingControllerCode.text.isEmpty){
      Toast.show('验证码不能为空');
      return;
    }
    if(_editingControllerPassword.text.isEmpty){
      Toast.show('密码不能为空');
      return;
    }
    if(signImage.isEmpty){
      Toast.show('请对司机服务协议进行签名');
      return;
    }


  }
  //给image data 添加一个路径
  void _saveToImage(Uint8List mUint8List,String name) async  {
    name = md5.convert(utf8.encode(name)).toString();
    Directory dir = await getTemporaryDirectory();
    String path = dir.path +"/"+name+'.jpg';
    var file = File(path);
    File(path).writeAsBytesSync(mUint8List);
//    bool exist =  await file.exists();
//    if(!exist) {
//      File(path).writeAsBytesSync(mUint8List);
//    }
    debugPrint("image save in path =${file.path}");
    if (file != null && file.path != null) {
      //todo 上传图片
      String url = await UploadUtils.uploadImage2(file.path);
      debugPrint('sign image url = $url');
      if ((url ?? "").isNotEmpty) {
        signImage = url;
        startRegister();
      }else{
        Toast.show('提交失败，请重新签名');
        AppPush.pushDefault(_buildContext, CompleteInfoPage());
      }
    }
  }
}
