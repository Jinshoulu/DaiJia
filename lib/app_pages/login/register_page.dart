
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:demo/app_pages/login/SignContainer.dart';
import 'package:demo/app_pages/login/complete_info_page.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/dialog/empty_bottom_sheet.dart';
import 'package:demo/z_tools/image/AppSubmitImage.dart';
import 'package:demo/z_tools/net/UploadUtils.dart';
import 'package:demo/z_tools/text_field/app_code_text_field.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flustars/flustars.dart';
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
  TextEditingController _editingControllerPasswordConfirm = new TextEditingController();

  FocusNode _focusNodePhone = new FocusNode();
  FocusNode _focusNodePassword = new FocusNode();
  FocusNode _focusNodeCode = new FocusNode();
  FocusNode _focusNodePasswordConfirm = new FocusNode();

  bool isAgree = false;
  ///司机服务协议
  String driverServiceDelegate = '';

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

    getDriverServiceDelegate();
  }


  getDriverServiceDelegate(){

    DioUtils.instance.post(Api.drivingDelegateUrl,onFailure: (code,msg){

    },onSucceed: (response){
        if(response is Map){
          if(response['content']!=null){
            driverServiceDelegate = response['content'];
          }
        }
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
        list: [_focusNodePhone,_focusNodeCode,_focusNodePassword,_focusNodePasswordConfirm],
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
                      type: '2',
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
                      showPass: true,
                      focusNode: _focusNodePassword
                  ),
                  AppTextField(
                      edgeInsets: EdgeInsets.all(0.0),
                      keyName: 'confirmPassword',
                      controller: _editingControllerPasswordConfirm,
                      mode: TexFieldMode.fourMode,
                      leftImage: '登录密码',
                      hintText: '请输入确认密码',
                      showPass: true,
                      focusNode: _focusNodePasswordConfirm
                  ),
                  SizedBox(height: 100.0,),
                  SizedBox(
                    height: 50.0,
                    child: AppButton(
                        radius: 50.0,
                        bgColor: AppColors.mainColor,
                        title: '确认',textStyle: TextStyles.whiteAnd14,
                        onPress: (){
                          requestRegister();
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
                            AppShowBottomDialog.showDelegateDialog(context, '司机服务协议', driverServiceDelegate, (){
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

  requestRegister(){

    if(_editingControllerPhone.text.isEmpty){
      Toast.show('请输入手机号');
      return;
    }
    if(_editingControllerCode.text.isEmpty||_editingControllerCode.text.length!=6){
      Toast.show('请输入正确的验证码');
      return;
    }
    if(_editingControllerPassword.text.isEmpty){
      Toast.show('请输入密码');
      return;
    }
    if(_editingControllerPasswordConfirm.text.isEmpty){
      Toast.show('请输入确认密码');
      return;
    }
    if(_editingControllerPassword.text != _editingControllerPasswordConfirm.text){
      Toast.show('两次密码不一致');
      return;
    }

    var data = {
      'phone': _editingControllerPhone.text,
      'verify':_editingControllerCode.text,
      'newpwd':_editingControllerPassword.text,
      'repwd':_editingControllerPasswordConfirm.text,
      'province_id':SpUtil.getString(AppValue.user_province_id,defValue: ''),
      'city_id':SpUtil.getString(AppValue.user_city_id,defValue: ''),
      'area_id':SpUtil.getString(AppValue.user_area_id,defValue: '')
    };

    DioUtils.instance.post(Api.registerUrl,context: this.context,data:data,onFailure: (code,msg){

    },onSucceed: (response){
      Toast.show('注册成功,请填写您的签名');
      showSignWidget();
    });

  }

  showSignWidget(){
    showModalBottomSheet(
      context: this.context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SignContainer(
          onSuccess: (){
            startLogin();
          },
        );
      },
    );
  }

  startLogin(){

    var data = {
      'phone': _editingControllerPhone.text,
      'password':_editingControllerPassword.text,
      'province_id':SpUtil.getString(AppValue.user_province_id,defValue: ''),
      'city_id':SpUtil.getString(AppValue.user_city_id,defValue: ''),
      'area_id':SpUtil.getString(AppValue.user_area_id,defValue: ''),
      'lon':SpUtil.getString(AppValue.user_local_long,defValue: ''),
      'lat':SpUtil.getString(AppValue.user_local_late,defValue: ''),
      'address':SpUtil.getString(AppValue.user_local_address,defValue: ''),
      'device':SpUtil.getString(AppValue.user_only_one_id,defValue: ''),
      'jg_device':SpUtil.getString(AppValue.user_j_push_id,defValue: ''),
    };

    DioUtils.instance.post(Api.loginUrl,context: this.context,data:data,onFailure: (code,msg){

    },onSucceed: (response){
      if(response is Map){
        if(response['token']!=null){
          SpUtil.putString(AppValue.login_account, _editingControllerPhone.text);
          SpUtil.putString(AppValue.token, response['token'].toString());
          SpUtil.putInt(AppValue.token_expiration, response['expiration']);
          SpUtil.putString(AppValue.refresh_token, response['refertoken'].toString());
          SpUtil.putBool(AppValue.login_state,true);
          AppPush.push(this.context, Routes.home);
        }else{
          Toast.show('请求结果，格式不正确，请联系服务端人员');
        }
      }else{
        Toast.show('请求结果，格式不正确，请联系服务端人员');
      }
    });
  }


}
