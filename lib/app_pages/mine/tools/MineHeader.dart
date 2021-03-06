
import 'package:demo/app_pages/mine/MineInfo.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverAccountDetail.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverPointsRecord.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverWithdrawalList.dart';
import 'package:demo/provider/user_info.dart';
import 'package:demo/z_tools/app_widget/AppBoldText.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/image/image_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public_header.dart';

class MineHeader extends StatefulWidget {
  @override
  _MineHeaderState createState() => _MineHeaderState();
}

class _MineHeaderState extends State<MineHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 0,right: 0,top: 0,bottom: 70.0,
              child: LoadAssetImage('我的-顶部背景',radius: 0.0,)
          ),
          Positioned(
              left: 0,right: 0,top: 0,bottom: 70.0,
              child: Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).padding.top,),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 35.0,
                      child: AppButton(alignment: Alignment.centerRight,title: '平安到家',textStyle: TextStyles.whiteAnd14, onPress: (){

                      }),
                    ),
                    InkWell(
                      onTap: (){
                        AppPush.pushDefault(context, MineInfoPage());
                      },
                      child: Container(
                        height: 100.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                  border: Border.all(color: AppColors.whiteColor,width: 5)
                              ),
                              alignment: Alignment.center,
                              child: ImageHeader(image: Provider.of<UserInfo>(context).headimage??'',height: 80.0,),
                            ),
                            SizedBox(width: 10.0,),
                            Expanded(child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        AppBoldText(text: Provider.of<UserInfo>(context).nickname??'',color: AppColors.whiteColor,fonSize: 18,),
                                        SizedBox(width: 10,),
                                        Container(
                                          width: 45.0,
                                          height: 20.0,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                              border: Border.all(color: AppColors.orangeColor,width: 1)
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              LoadAssetImage('我的-星星',width: 10,height: 10,radius: 0.0,),
                                              SizedBox(width: 5,),
                                              AppText(text: Provider.of<UserInfo>(context).star??'',color: AppColors.orangeColor,fonSize: 12,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextContainer(
                                      title: '工号: ${Provider.of<UserInfo>(context).code??''}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.whiteColor
                                      )
                                  ),
                                ),
                                Expanded(
                                  child: TextContainer(
                                      title: '手机号: ${Provider.of<UserInfo>(context).phone??''}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.whiteColor
                                      )
                                  ),
                                ),
                              ],
                            ))

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
          Positioned(
              left: 16,right: 16,bottom: 0,
              child: Card(
                child: Container(
                  height: 120,
                  padding: EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 10),
                  child: Row(
                    children: <Widget>[
                      createHeaderContainer(
                          '我的-代驾分',
                          '代驾分(分)',
                          '${Provider.of<UserInfo>(context).branch??''}/12',
                          ''
                      ),
                      AppSizeBox(width: 1,height: 60,),
                      createHeaderContainer(
                          '账户明细',
                          '账户明细(元)',
                          Provider.of<UserInfo>(context).imoney??'',
                          '可提现${Provider.of<UserInfo>(context).money??''}元'),
                    ],
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  createHeaderContainer(image,title,value,content){
    return Expanded(
        child: InkWell(
          onTap: (){
            if(title=='代驾分(分)'){
              AppPush.pushDefault(context, DriverPointsRecord());
            }else{
              AppPush.pushDefault(context, DriverAccountDetail());
            }
          },
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 10,),
                Container(
                  width: 35.0,
                  child: LoadAssetImage(image,width: 35.0,radius: 0.0,),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextContainer(title: title, height: 20.0, style: TextStyles.blackAnd12),
                      TextContainer(
                          title: value,
                          height: 45.0,
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColors.red,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      TextContainer(title: content, height: 20.0, style: TextStyle(fontSize: 12,color: AppColors.black54Color)),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
