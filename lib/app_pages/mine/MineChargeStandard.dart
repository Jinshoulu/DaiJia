
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
  var oneData;
  var twoData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(initialPage: 0);
    readData();
    getData();
    getData22();
  }

  //读取缓存
  readData(){
    AppClass.readData(Api.mineGetPriceUrl+'1').then((value){
      if(value!=null){
        setState(() {
          oneData = value;
        });
      }
    });
    AppClass.readData(Api.mineGetPriceUrl+'2').then((value){
      if(value!=null){
        setState(() {
          twoData = value;
        });
      }
    });
  }
  getData(){
    var data = {
      'type':1,
    };
    DioUtils.instance.post(Api.mineGetPriceUrl,data: data, onFailure: (code,msg){

    },onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.mineGetPriceUrl+'1');
        oneData = response;
        if(mounted){
          setState(() {

          });
        }
      }
    });
  }

  getData22(){
    var data = {
      'type':2,
    };
    DioUtils.instance.post(Api.mineGetPriceUrl,data: data, onFailure: (code,msg){

    },onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.mineGetPriceUrl+'2');
        twoData = response;
        if(mounted){
          setState(() {});
        }
      }
    });
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
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Html(
                        data: AppClass.data(oneData, 'content')
                    ),
                  );
                }else{
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Html(
                        data: AppClass.data(twoData, 'content')
                    ),
                  );
                }

              }
          )
      ),
    );
  }
}
