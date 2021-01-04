
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      height: 50.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 70,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: TextContainer(
                      alignment: Alignment.center,
                        title: '公司公告',
                        height: 40,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor
                        )
                    )
                ),
                Positioned(left:0, right: 0,bottom: 0,child: Container(
                  height: 3,decoration: BoxDecoration(
                    color: AppColors.mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(4))
                ),))
              ],
            ),
          ),
          SizedBox(width: 30,),
          createExpand('返现提醒', 99),
          SizedBox(width: 30,),
          createExpand('订单提醒', 99),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  createExpand(String title, int number){
    return Container(
      width: 80,
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: TextContainer(title: title, height: 40, style: TextStyle(fontSize: 14))),
          Positioned(
              top: 5,
              right: 10,
              child: Container(
                alignment: Alignment.center,
                height: 15,
                width: 15,
                child: Text(
                  number.toString(),
                  style: TextStyle(fontSize: 10, color: AppColors.whiteColor),
                ),
                decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ))
        ],
      ),
    );
  }
}
