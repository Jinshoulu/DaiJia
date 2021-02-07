

import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_label_cell.dart';
import 'package:demo/z_tools/app_widget/app_set_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/dialog/update_dialog.dart';
import 'package:demo/z_tools/save_data.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../public_header.dart';

class MineAbout extends StatefulWidget {
  @override
  _MineAboutState createState() => _MineAboutState();
}

class _MineAboutState extends State<MineAbout> {

  

  AboutBean bean;
  bool update = true;

  PackageInfo packageInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
    getReadData();
    update = SpUtil.getBool(SaveData.smartUpdate,defValue: true);
    getData();
  }

  getInfo()async{
    await PackageInfo.fromPlatform().then((value){
      setState(() {
        packageInfo = value;
      });
    });
  }

  //获取保存数据
  getReadData(){

    AppClass.readData(Api.aboutUsUrl).then((value){
      if(value!=null){
        setState(() {
          bean = AboutBean.fromJson(value);
        });
      }
    });

  }

  //获取信息
  getData(){
    DioUtils.instance.post(Api.aboutUsUrl, onFailure: (code,msg){},onSucceed: (response){
      if(response is Map){
        if(mounted){
          setState(() {
            AppClass.saveData(response, Api.aboutUsUrl);
            bean = AboutBean.fromJson(response);
          });
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '关于我们',
        rightWidget: AppButton(
            title: '平安到家',
            textStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),
            onPress: (){

            }
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            AppSizeBox(),
            Container(
              height: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LoadImage(bean?.logo_url??'',holderImg: 'ic_launcher',width: 80.0,height: 80.0,radius: 0.0,),
                  TextContainer(alignment: Alignment.center,title: packageInfo?.appName??'', height: 40.0, style: TextStyles.blackAnd14)
                ],
              ),
            ),
            AppSizeBox(),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: Column(
                children: <Widget>[
                  ContainerAddLineWidget(
                    disW: 10.0,
                      child: AppCell(
                        edgeInsets: EdgeInsets.only(left: 0,right: 0),
                        title: '现在版本号', content: packageInfo?.version??'',contentStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),),
                  ),
                  ContainerAddLineWidget(
                    disW: 10.0,
                    child: AppLabelCell(
                      edgeInsets: EdgeInsets.only(left: 0,right: 0),
                      title: '检查版本号',
                      showLine: false,
                      onPress: (){
                        UpdateApp.determineAppVersion(this.context, false);
                      },
                    ),
                  ),
                  ContainerAddLineWidget(
                    disW: 10.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: AppText(text: '新版本自动升级',alignment: Alignment.centerLeft,)),
                        SizedBox(width: 50.0,child: AppButton(
                            image: update?'开关-开':'开关-关',
                            buttonType: ButtonType.onlyImage,
                            onPress: (){
                              setState(() {
                                update = !update;
                                SpUtil.putBool(SaveData.smartUpdate, update);
                              });
                            }
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox(),),
            SizedBox(
              height: 30.0,
              child: AppText(text: '北京恒泰正道科技有限公司',color: AppColors.black54Color,),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    child: AppButton(
                        title: '《客服服务协议》',
                        textStyle: TextStyle(fontSize: 14,color: AppColors.blueColor),
                        onPress: (){
                          AppClass.readData(Api.userServiceDelegateUrl).then((value) {
                            if (value != null) {
                              AppPush.goHtmlPage(this.context, '客服服务协议', AppClass.data(value, 'content'));
                            } else {
                              getUserDelegate();
                            }
                          });
                        }
                    ),
                  ),
                  AppSizeBox(width: 1,height: 30,),
                  SizedBox(
                    height: 30,
                    child: AppButton(
                        title: '《隐私保护协议》',
                        textStyle: TextStyle(fontSize: 14,color: AppColors.blueColor),
                        onPress: (){
                          AppClass.readData(Api.privacyUrl).then((value) {
                            if (value != null) {
                              AppPush.goHtmlPage(this.context, '隐私保护协议', AppClass.data(value, 'content'));
                            } else {
                              getPolicyDelegate();
                            }
                          });
                        }
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

  //用户协议
  getUserDelegate(){

    DioUtils.instance.post(Api.userServiceDelegateUrl,onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.userServiceDelegateUrl);
        AppPush.goHtmlPage(this.context, '客服服务协议', AppClass.data(response, 'content'));
      }else{
        Toast.show('返回格式错误,请联系服务端');
      }
    },onFailure: (code,msg){

    });

  }

  //隐私协议
  getPolicyDelegate(){

    DioUtils.instance.post(Api.privacyUrl,onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.privacyUrl);
        AppPush.goHtmlPage(this.context, '隐私保护协议', AppClass.data(response, 'content'));
      }else{
        Toast.show('返回格式错误,请联系服务端');
      }
    },onFailure: (code,msg){

    });

  }

}

class AboutBean {
    String company;
    String logo_url;
    String tel;
    String wechat;

    AboutBean({this.company, this.logo_url, this.tel, this.wechat});

    factory AboutBean.fromJson(Map<String, dynamic> json) {
        return AboutBean(
            company: json['company'], 
            logo_url: json['logo_url'], 
            tel: json['tel'], 
            wechat: json['wechat'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['company'] = this.company;
        data['logo_url'] = this.logo_url;
        data['tel'] = this.tel;
        data['wechat'] = this.wechat;
        return data;
    }
}
