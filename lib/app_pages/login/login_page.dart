
import 'package:demo/app_pages/be_user_common/AppLocal.dart';
import 'package:demo/app_pages/login/SignContainer.dart';
import 'package:demo/provider/user_info.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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

    AppLocal.getLocation(this.context).then((value){
      print(value);
    });

    AppClass.netFetch().then((value){
      print('current device id = $value');
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _editingControllerPhone.text = SpUtil.getString(AppValue.login_account);
    });
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
                                String provinceId = SpUtil.getString(AppValue.user_province_id);
                                String cityId = SpUtil.getString(AppValue.user_city_id);
                                String areaId = SpUtil.getString(AppValue.user_area_id);
                                if(provinceId.isEmpty||cityId.isEmpty||areaId.isEmpty){
                                  AppLocal.getLocation(this.context).then((value){
                                    startLoginRequest();
                                  });
                                }else{
                                  startLoginRequest();
                                }

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

  startLoginRequest(){

    _focusNodePhone.unfocus();
    _focusNodePassword.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if(_editingControllerPhone.text.isEmpty){
      Toast.show('请输入手机号');
      return;
    }
    if(_editingControllerPassword.text.isEmpty){
      Toast.show('请输入密码');
      return;
    }

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
        if(response['autograph'] !=null){
          if(response['autograph'].toString().isEmpty){
            SpUtil.putString(AppValue.login_account, _editingControllerPhone.text);
            SpUtil.putString(AppValue.token, response['token'].toString());
            SpUtil.putInt(AppValue.token_expiration, response['expiration']);
            SpUtil.putString(AppValue.refresh_token, response['refertoken'].toString());
            showSignWidget();
          }else{
            SpUtil.putString(AppValue.login_account, _editingControllerPhone.text);
            SpUtil.putString(AppValue.token, response['token'].toString());
            SpUtil.putInt(AppValue.token_expiration, response['expiration']);
            SpUtil.putString(AppValue.refresh_token, response['refertoken'].toString());
            SpUtil.putBool(AppValue.login_state,true);
            AppPush.push(this.context, Routes.home);
          }
        }else{
          Toast.show('请求结果，格式不正确，请联系服务端人员');
        }
      }else{
        Toast.show('请求结果，格式不正确，请联系服务端人员');
      }
    });

  }

  showSignWidget(){
    showModalBottomSheet(
      context: this.context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return SignContainer(
          onSuccess: (){
            SpUtil.putBool(AppValue.login_state,true);
            AppPush.push(this.context, Routes.home);
          },
        );
      },
    );
  }

}
