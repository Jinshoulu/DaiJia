

import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_label_cell.dart';
import 'package:demo/z_tools/app_widget/app_set_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/save_data.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

class MineAbout extends StatefulWidget {
  @override
  _MineAboutState createState() => _MineAboutState();
}

class _MineAboutState extends State<MineAbout> {

  

  AboutBean bean;
  bool update = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    update = SpUtil.getBool(SaveData.smartUpdate,defValue: true);


    getData();
  }

  getData(){

    DioUtils.instance.get(Api.aboutUsUrl, onFailure: (code,msg){},onSucceed: (response){

      setState(() {
        bean = AboutBean.fromJson(response);
      });

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
                  LoadAssetImage('defaultImage',width: 80.0,height: 80.0,radius: 0.0,),
                  TextContainer(alignment: Alignment.center,title: '标兵代驾', height: 40.0, style: TextStyles.blackAnd14)
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
                        title: '现在版本号', content: '1.0.0',contentStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),),
                  ),
                  ContainerAddLineWidget(
                    disW: 10.0,
                    child: AppLabelCell(
                      edgeInsets: EdgeInsets.only(left: 0,right: 0),
                      title: '检查版本号',
                      showLine: false,
                      onPress: (){

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
                          getMinaze();
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
                          getYinsi();
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

  getMinaze(){

//    if(SpUtil.getString(SaveData.liabilityHtml).isEmpty){
//      AppPush.goHtmlPage(context, '免责声明', SpUtil.getString(SaveData.liabilityHtml));
//    }

//    DioUtils.instance.post(Api.getLiabilityUrl,context: this.context,onFailure: (code,msg){
//
//    },onSucceed: (response){
//
//      SpUtil.putString(SaveData.privacyHtml, response);
//      AppPush.goHtmlPage(this.context, '免责声明', response);
//
//    });
  }

  getYinsi(){

//    if(SpUtil.getString(SaveData.privacyHtml).isEmpty){
//      AppPush.goHtmlPage(context, '隐私协议', SpUtil.getString(SaveData.privacyHtml));
//    }

//    DioUtils.instance.post(Api.getPrivacyUrl,context: this.context,onFailure: (code,msg){
//
//    },onSucceed: (response){
//
//      SpUtil.putString(SaveData.privacyHtml, response);
//      AppPush.goHtmlPage(this.context, '隐私协议', response);
//
//    });
  }

}

class AboutBean {
    String com_name;
    String contactus;
    String url;
    String wechat;

    AboutBean({this.com_name, this.contactus, this.url, this.wechat});

    factory AboutBean.fromJson(Map<String, dynamic> json) {
        return AboutBean(
            com_name: json['com_name'].toString(),
            contactus: json['contactus'].toString(),
            url: json['url'].toString(),
            wechat: json['wechat'].toString(),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['com_name'] = this.com_name;
        data['contactus'] = this.contactus;
        data['url'] = this.url;
        data['wechat'] = this.wechat;
        return data;
    }
}