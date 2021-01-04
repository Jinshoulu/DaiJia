
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

class TopCardDetail extends StatefulWidget {
  @override
  _TopCardDetailState createState() => _TopCardDetailState();
}

class _TopCardDetailState extends State<TopCardDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      padding: EdgeInsets.only(left: 16,right: 16,top: 20),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoadAssetImage('首页卡片'),
          Container(
            padding: EdgeInsets.only(left: 16,top: 10,right: 16,bottom: 10),
            child: Column(
              children: <Widget>[
                TextContainer(title: '今日收入(元)', height: 20, style: TextStyle(fontSize: 13,color: AppColors.whiteColor)),
                TextContainer(title: '1162.00', height: 30.0, style: TextStyles.getWhiteBoldText(25)),
                SizedBox(height: 5,),
                Expanded(child: Row(
                  children: <Widget>[
                    createExpandWidget('52', '今日在线(分)'),
                    SizedBox(width: 10,),
                    SizedBox(width: 1,height: double.infinity,child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.black12Color)),),
                    SizedBox(width: 10,),
                    createExpandWidget('23', '今日订单(单)'),
                  ],
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  createExpandWidget(String value,String title){
    return Expanded(child: Column(
      children: <Widget>[
        Expanded(child: Container(alignment: Alignment.centerLeft,child: Text(value,style: TextStyles.getWhiteBoldText(16),),),),
        Expanded(child: Container(alignment: Alignment.centerLeft,child: Text(title,style: TextStyle(fontSize: 13,color: AppColors.whiteColor),),),),
      ],
    ));
  }
}
