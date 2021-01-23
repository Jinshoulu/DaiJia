
import 'package:demo/app_pages/workbench/appointment/AppointmentHall.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:flutter/material.dart';

import 'NearPush.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment>{


  int isOne = 0;
  PageController _pageController = new PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowEmptyBar(
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
                  width: 100.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),bottomLeft:Radius.circular(40.0)),
                      border: Border.all(color: AppColors.mainColor,width: 1),
                      color: isOne==0?AppColors.mainColor:AppColors.whiteColor
                  ),
                  child: AppText(text: '预约大厅',color: isOne==0?AppColors.whiteColor:AppColors.mainColor,),
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
                  width: 100.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40.0),bottomRight:Radius.circular(40.0)),
                      border: Border.all(color: AppColors.mainColor,width: 1),
                      color: isOne==1?AppColors.mainColor:AppColors.whiteColor
                  ),
                  child: AppText(text: '附近配送',color: isOne==1?AppColors.whiteColor:AppColors.mainColor,),
                ),
              )
            ],
          ),
        ),
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
          new AppointmentHall(),
          new NearPush(),
        ],
      ),
    );
  }
}
