
import 'package:demo/provider/user_info.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/text_field/app_code_text_field.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../public_header.dart';

class ModifyPassword extends StatefulWidget {
  @override
  _ModifyPasswordState createState() => _ModifyPasswordState();
}

class _ModifyPasswordState extends State<ModifyPassword> {
  TextEditingController _editingControllerPhone = new TextEditingController();
  TextEditingController _editingControllerCode = new TextEditingController();
  TextEditingController _editingControllerPassword = new TextEditingController();

  FocusNode _focusNodePhone = new FocusNode();
  FocusNode _focusNodeCode = new FocusNode();
  FocusNode _focusNodePassword = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _editingControllerPhone.text = SpUtil.getString(AppValue.login_account,defValue: '');

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return KeyboardActionWidget(
        list: [_focusNodePhone,_focusNodeCode,_focusNodePassword],
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: ShowWhiteAppBar(
            centerTitle: '修改密码',
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
                      keyboardType: TextInputType.text,
                      showPass: true,
                      leftImage: '登录密码',
                      hintText: '请输入新密码',
                      focusNode: _focusNodePassword
                  ),
                  SizedBox(height: 100.0,),
                  SizedBox(
                    height: 50.0,
                    child: AppButton(
                        radius: 50.0,
                        bgColor: AppColors.mainColor,
                        title: '确定修改',textStyle: TextStyles.whiteAnd14,
                        onPress: (){
                          modifyPassword();
                        }
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

  modifyPassword(){

    if(_editingControllerPhone.text.isEmpty){
      Toast.show('请输入手机号');
      return;
    }
    if(_editingControllerCode.text.isEmpty){
      Toast.show('请输入验证码');
      return;
    }
    if(_editingControllerCode.text.length!=6){
      Toast.show('输入的验证码格式有误');
      return;
    }
    if(_editingControllerPassword.text.isEmpty){
      Toast.show('请输入新密码');
      return;
    }

    var data = {
      'phone': _editingControllerPhone.text,
      'password':_editingControllerPassword.text,
      'verify': _editingControllerCode.text
    };
    DioUtils.instance.post(Api.centerIndexUrl,data: data,onSucceed: (response){
      Toast.show('修改完成,请重新登录');
      AppClass.exitApp(this.context);
    },onFailure: (code,msg){

    });
  }
}
