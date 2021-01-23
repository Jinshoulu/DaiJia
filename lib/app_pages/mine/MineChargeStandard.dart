
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MineChargeStandard extends StatefulWidget {
  @override
  _MineChargeStandardState createState() => _MineChargeStandardState();
}

class _MineChargeStandardState extends State<MineChargeStandard> {

  PageController _pageController;
  int isOne = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(initialPage: 0);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowWhiteAppBar(
        centerTitle: '收费标准',
        rightWidget: AppButton(
            title: '平安到家',
            textStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),
            onPress: (){

            }
        ),
      ),
      body: AppStackWidget(
          isUp: true,
          height: 80.0,
          topWidget: Container(
            color: Colors.white,
            height: 60.0,
            margin: EdgeInsets.only(top: 10,bottom: 10),
            alignment: Alignment.center,
            child: Container(
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
                      child: AppText(text: '日常代驾',color: isOne==0?AppColors.whiteColor:AppColors.mainColor,),
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
                      child: AppText(text: '长途商务',color: isOne==1?AppColors.whiteColor:AppColors.mainColor,),
                    ),
                  )
                ],
              ),
            ),
          ),
          downWidget: PageView.builder(
              controller: _pageController,
              itemCount: 2,
              itemBuilder: (BuildContext context,int index){
                if(index==0){
                  return Container(
                    color: Colors.white,
                    child: Html(
                        data: '日常代驾的收费标准'
                    ),
                  );
                }else{
                  return Container(
                    color: Colors.white,
                    child: Html(
                        data: '长途商务的收费标准'
                    ),
                  );
                }

              }
          )
      ),
    );
  }
}
