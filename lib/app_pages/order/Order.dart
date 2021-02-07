
import 'package:demo/app_pages/order/OrderDone.dart';
import 'package:demo/app_pages/order/OrderWorking.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {

  int isOne = 0;
  PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowEmptyBar(
        leftWidget: SizedBox(
            width: 70.0,
            child: AppButton(
                title: '推送单',
                textStyle: TextStyles.mainAnd14,
                onPress: (){

                })),
        centerWidget: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: (){
                  setState(() {
                    isOne = 0;
                    _pageController.jumpToPage(isOne);
                  });
                },
                child: Container(
                  width: 80.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),bottomLeft:Radius.circular(40.0)),
                      border: Border.all(color: AppColors.mainColor,width: 1),
                      color: isOne==0?AppColors.mainColor:AppColors.whiteColor
                  ),
                  child: AppText(text: '进行中',color: isOne==0?AppColors.whiteColor:AppColors.mainColor,),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    isOne = 1;
                    _pageController.jumpToPage(isOne);
                  });
                },
                child: Container(
                  width: 80.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40.0),bottomRight:Radius.circular(40.0)),
                      border: Border.all(color: AppColors.mainColor,width: 1),
                      color: isOne==1?AppColors.mainColor:AppColors.whiteColor
                  ),
                  child: AppText(text: '已完成',color: isOne==1?AppColors.whiteColor:AppColors.mainColor,),
                ),
              ),
            ],
          ),
        ),
        rightWidget: SizedBox(
            width: 70.0,
            child: AppButton(
                title: '我派的单',
                textStyle: TextStyles.mainAnd14,
                onPress: (){

                })),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index){
          debugPrint("当前索引：" + index.toString());
          isOne=index;
          if (mounted) {
            setState(() {});
          }
        },
        children: <Widget>[
          new OrderWorking(),
          new OrderDone(),
        ],
      ),
    );
  }
}
