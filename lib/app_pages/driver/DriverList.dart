
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppBoldText.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/image/image_header.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/material.dart';

class DroverList extends StatefulWidget {
  @override
  _DroverListState createState() => _DroverListState();
}

class _DroverListState extends State<DroverList> {

  List dataList = [];

  @override
  Widget build(BuildContext context) {

    return AppRefreshWidget(
        itemBuilder: (BuildContext context, int index){
          Widget child;
          switch(index%3){
            case 0:{
              child = Container(
                width: 40.0,
                height: 20.0,
                alignment: Alignment.center,
                child: Text('忙碌',style: TextStyles.whiteAnd12,),
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.all(Radius.circular(2.0))
                ),
              );
            }break;
            case 1:{
              child = Container(
                width: 40.0,
                height: 20.0,
                alignment: Alignment.center,
                child: Text('空闲',style: TextStyles.whiteAnd12,),
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(2.0))
                ),
              );
            }break;
            default:{
              child = Container(
                width: 40.0,
                height: 20.0,
                alignment: Alignment.center,
                child: Text('下班',style: TextStyles.whiteAnd12,),
                decoration: BoxDecoration(
                    color: AppColors.black54Color,
                    borderRadius: BorderRadius.all(Radius.circular(2.0))
                ),
              );
            }break;
          }

          return Container(
            color: AppColors.whiteColor,
            height: 50+80.0,
            child: Column(
              children: <Widget>[
                AppSizeBox(),
                SizedBox(height: 10,),
                Expanded(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                          Container(
                            width: 100.0,
                            alignment: Alignment.center,
                            child: ImageHeader(
                              image: 'defaultImage',
                              height: 80.0,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Row(
                                        children: <Widget>[
                                          AppBoldText(text: '皮卡丘'),
                                          SizedBox(width: 10,),
                                          child,
                                          Expanded(
                                              child: AppText(
                                                alignment: Alignment.centerRight,
                                                text: '50m',
                                                color: AppColors.black54Color,
                                              )
                                          )
                                        ],
                                      ),
                                    )
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: AppText(
                                                              alignment: Alignment.centerLeft,
                                                              text: '代驾: 155次',
                                                            )
                                                        ),
                                                        Expanded(
                                                            child: AppText(
                                                              alignment: Alignment.centerLeft,
                                                              text: '驾龄: 11年',
                                                            )
                                                        )
                                                      ],
                                                    )
                                                ),
                                                Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        AppText(
                                                          alignment: Alignment.centerLeft,
                                                          text: '服务:',
                                                        ),
                                                        Container(
                                                          alignment: Alignment.center,
                                                          child: LoadAssetImage('司机-星星',width: 15,height: 15,radius: 0.0,),
                                                        ),
                                                        Expanded(
                                                            child: AppText(
                                                              alignment: Alignment.centerLeft,
                                                              text: '5.0',
                                                            )
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ],
                                            )
                                        ),
                                        InkWell(
                                          onTap: (){
                                            AppShowBottomDialog.showCallPhoneDialog('188569324568', context);
                                          },
                                          child: Container(
                                            width: 80.0,
                                            alignment: Alignment.center,
                                            child: ImageHeader(
                                              height: 40,
                                              image: '订单-电话',
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          );
        },
        requestData: {},
        requestUrl: Api.baseApi,
        requestBackData:(List list){
          if(mounted){
            setState(() {
              dataList = list;
            });
          }
        }
    );
  }
}
