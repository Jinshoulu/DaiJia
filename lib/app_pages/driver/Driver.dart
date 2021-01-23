
import 'package:demo/app_pages/driver/DriverList.dart';
import 'package:demo/app_pages/driver/DriverMap.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:flutter/material.dart';

class Driver extends StatefulWidget {
  @override
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> {

  PageController _pageController = new PageController();
  int isOne = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowEmptyBar(
        leftWidget: SizedBox(width: 48.0,),
        rightWidget: Container(
          width: 48.0,
          child: AppButton(image: '司机-刷新',imageSize: 25,buttonType: ButtonType.onlyImage, onPress: (){

          }),
        ),
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
                  child: AppText(text: '地图',color: isOne==0?AppColors.whiteColor:AppColors.mainColor,),
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
                  child: AppText(text: '列表',color: isOne==1?AppColors.whiteColor:AppColors.mainColor,),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: PageView(
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
            new DriverMap(),
            new DroverList(),
          ],
        ),
      ),
    );
  }
}
