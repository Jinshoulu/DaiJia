
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/material.dart';

import 'MineAdmentDetail.dart';

class MineDriverClass extends StatefulWidget {
  @override
  _MineDriverClassState createState() => _MineDriverClassState();
}

class _MineDriverClassState extends State<MineDriverClass> {

  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '司机学堂',
        rightWidget: AppButton(
            title: '平安到家',
            textStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),
            onPress: (){

            }
        ),
      ),
      body: AppRefreshWidget(
          itemBuilder: (BuildContext context,int index){
            return createContainerItem(index);
          },
          requestData: {},
          requestUrl: Api.baseApi,
          requestBackData: (List list){
            if(mounted){
              setState(() {
                dataList = list;
              });
            }
          }
      ),
    );
  }

  createContainerItem(int index){
    String content = '未学习';
    Color color  = AppColors.red;
    switch(index%3){
      case 0:{
        content = '已学习';
        color = AppColors.greenColor;
      }break;
      case 1:{
        content = '学习中';
        color = AppColors.orangeColor;
      }break;
      default:{}break;
    }
    return InkWell(
      onTap: (){
        AppPush.pushDefault(context, MineAdmentDetail(id: '10',));
      },
      child: ContainerAddLineWidget(
        height: 70.0,
          child: Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30.0,
                          child: AppText(
                            text: '罪及客户必须确保家付给其他家人,或者交给警察,不然出现意外,可能回程单责任',
                            alignment: Alignment.centerLeft,
                            color: AppColors.blackColor,
                          ),
                        ),
                        Container(
                          height: 20.0,
                          child: AppText(
                            text: '2021-12-12 12:12',
                            alignment: Alignment.centerLeft,
                            fonSize: 12,
                            color: AppColors.black54Color,
                          ),
                        )
                      ],
                    )
                ),
                Container(
                  width: 60,
                  child: AppText(
                    text: content,
                    color: color,
                  ),
                ),
                Container(
                  width: 20.0,
                  alignment: Alignment.center,
                  child: LoadAssetImage('ic_arrow_right',width: 12,fit: BoxFit.fitWidth,radius: 0.0,),
                )
              ],
            ),
          )
      ),
    );
  }
}
