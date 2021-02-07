
import 'package:demo/app_pages/login/SignContainer.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/text_field/app_code_text_field.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

class PasswordPage extends StatefulWidget {

  final int type;
  const PasswordPage({Key key, this.type}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController _editingControllerPhone = new TextEditingController();
  TextEditingController _editingControllerCode = new TextEditingController();

  FocusNode _focusNodePhone = new FocusNode();
  FocusNode _focusNodeCode = new FocusNode();

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
        list: [_focusNodePhone,_focusNodeCode],
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: ShowWhiteAppBar(
            centerTitle: '忘记密码',
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
                  SizedBox(height: 100.0,),
                  SizedBox(
                    height: 50.0,
                    child: AppButton(
                        radius: 50.0,
                        bgColor: AppColors.mainColor,
                        title: '登录',textStyle: TextStyles.whiteAnd14,
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
      Toast.show('请输入登录验证码');
      return;
    }
    if(_editingControllerCode.text.length!=6){
      Toast.show('请输入正确的验证码');
      return;
    }

    var data = {
      'phone': _editingControllerPhone.text,
      'verify':_editingControllerCode.text,
      'province_id':SpUtil.getString(AppValue.user_province_id,defValue: ''),
      'city_id':SpUtil.getString(AppValue.user_city_id,defValue: ''),
      'area_id':SpUtil.getString(AppValue.user_area_id,defValue: ''),
      'lon':SpUtil.getString(AppValue.user_local_long,defValue: ''),
      'lat':SpUtil.getString(AppValue.user_local_late,defValue: ''),
      'address':SpUtil.getString(AppValue.user_local_address,defValue: ''),
      'device':SpUtil.getString(AppValue.user_only_one_id,defValue: ''),
      'jg_device':SpUtil.getString(AppValue.user_j_push_id,defValue: ''),
    };

    DioUtils.instance.post(Api.forgetPasswordUrl,context: this.context,data: data,onSucceed: (response){
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
    },onFailure: (code,msg){

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
