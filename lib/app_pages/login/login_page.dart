
import 'dart:io';

import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/res/utils.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _editingControllerPhone = new TextEditingController();
  TextEditingController _editingControllerPassword = new TextEditingController();

  FocusNode _focusNodePhone = new FocusNode();
  FocusNode _focusNodePassword = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editingControllerPhone.text = SpUtil.getString(AppValue.login_account);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActionWidget(
        list: [_focusNodePhone,_focusNodePassword],
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  LoadAssetImage('登录背景',radius: 0.0),
                  Container(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(flex: 2,child: SizedBox()),
                        TextContainer(title: '标兵代驾', height: 60, style: TextStyles.getBlackBoldText(35)),
                        TextContainer(title: '欢迎来到标兵代驾司机端', height: 25, style: TextStyles.blackAnd14),
                        SizedBox(height: 40.0,),
                        AppTextField(
                            edgeInsets: EdgeInsets.all(0.0),
                            keyName: 'phone',
                            controller: _editingControllerPhone,
                            mode: TexFieldMode.fourMode,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            leftImage: '登录手机',
                            hintText: '请输入手机号',
                            focusNode: _focusNodePhone
                        ),
                        AppTextField(
                            edgeInsets: EdgeInsets.all(0.0),
                            keyName: 'password',
                            controller: _editingControllerPassword,
                            mode: TexFieldMode.fourMode,
                            showPass: true,
                            leftImage: '登录密码',
                            hintText: '请输入密码',
                            focusNode: _focusNodePassword
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              AppButton(onPress: (){
                                AppPush.pushWithParameter(context, LoginRouter.resetPasswordPage,{'type':1});
                              },title: '忘记密码',textStyle: TextStyles.mainAnd14,),
                              Expanded(child: SizedBox()),
                              AppButton(onPress: (){
                                AppPush.push(context, LoginRouter.registerPage);
                              },title: '账号注册',textStyle: TextStyles.mainAnd14,),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        SizedBox(
                          height: 50.0,
                          child: AppButton(
                              radius: 50.0,
                              bgColor: AppColors.mainColor,
                              title: '登录',textStyle: TextStyles.whiteAnd14,
                              onPress: (){
                                AppPush.push(context, Routes.home);
                              }
                          ),
                        ),
                        Expanded(flex: 3,child: SizedBox()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );

  }

}
