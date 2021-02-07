
import 'package:demo/app_pages/workbench/driverCenter/DriverAccountDetail.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverConsumptionRecord.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverOnlineTime.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverOrderDetail.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverPointsRecord.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverRecharge.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverScoreDetail.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppBoldText.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

class DriverCenter extends StatefulWidget {
  @override
  _DriverCenterState createState() => _DriverCenterState();
}

class _DriverCenterState extends State<DriverCenter> {

  List<SliverModel> dataList = [];
  //信息
  var infoData;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataList.add(SliverModel('本月收入(元)', ''));
    dataList.add(SliverModel('上月收入(元)', ''));
    dataList.add(SliverModel('总收入(元)', ''));
    dataList.add(SliverModel('本月订单(个)', ''));
    dataList.add(SliverModel('上月订单(个)', ''));
    dataList.add(SliverModel('总订单(个)', ''));
    dataList.add(SliverModel('本月积分(分)', ''));
    dataList.add(SliverModel('上月积分(分)', ''));
    dataList.add(SliverModel('总积分(分)', ''));
    dataList.add(SliverModel('本月在线', ''));
    dataList.add(SliverModel('上月在线', ''));
    dataList.add(SliverModel('消费率(%)', ''));
    getData();
  }
  
  getData(){
    
    DioUtils.instance.post(Api.centerIndexUrl,onSucceed: (response){
      if(response is Map){
        if(mounted){
          setState(() {
            infoData = response;
            dataList.clear();
            dataList.add(SliverModel('本月收入(元)', AppClass.data(infoData, 'month_money')));
            dataList.add(SliverModel('上月收入(元)', AppClass.data(infoData, 'up_money')));
            dataList.add(SliverModel('总收入(元)', AppClass.data(infoData, 'allmoney')));
            dataList.add(SliverModel('本月订单(个)', AppClass.data(infoData, 'month_order')));
            dataList.add(SliverModel('上月订单(个)', AppClass.data(infoData, 'up_order')));
            dataList.add(SliverModel('总订单(个)', AppClass.data(infoData, 'allorder')));
            dataList.add(SliverModel('本月积分(分)', AppClass.data(infoData, 'month_integral')));
            dataList.add(SliverModel('上月积分(分)', AppClass.data(infoData, 'up_integral')));
            dataList.add(SliverModel('总积分(分)', AppClass.data(infoData, 'allint')));
            dataList.add(SliverModel('本月在线', '${AppClass.data(infoData, 'month_online')}'));
            dataList.add(SliverModel('上月在线', '${AppClass.data(infoData, 'up_online')}'));
            dataList.add(SliverModel('消费率(%)', AppClass.data(infoData, 'percent')));
          });
        }
      }
    },onFailure: (code,msg){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
//            physics: NeverScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    AppPush.goBack(context);
                  },
                  tooltip: 'Back',
                  padding: const EdgeInsets.all(12.0),
                  icon: LoadAssetImage('back_black',width: 25,height: 25,radius: 0.0,color: AppColors.whiteColor,),
                ) ,
                title: Text('司机中心'),
                centerTitle: true,
                floating: false,
                pinned: true,
                snap: false,
                expandedHeight: 250.0,
                flexibleSpace: new FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Positioned(left: 0,top: 0,right: 0,bottom: 70.0,child: LoadAssetImage('司机中心背景',radius: 0.0,)),
                      Positioned(left: 0,top: 0,right: 0,bottom: 50.0,child: Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 100,child: AppButton(title: '余额',textStyle: TextStyles.whiteAnd14, image: '司机中心-余额',imageSize: 15,buttonType: ButtonType.leftImage, onPress: (){})),
                            SizedBox(height: 2,),
                            TextContainer(alignment: Alignment.center,title: AppClass.data(infoData, 'money'), height: 50, style: TextStyles.getWhiteBoldText(40)),
                          ],
                        ),
                      )),
                      Positioned(left: 16,right: 16,bottom: 0,child: Card(
                        elevation: 4.0,
                        shadowColor: AppColors.lightBlueColor,
                        child: Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(child: AppButton(title: '账户明细',image: '司机中心-余额明细',imageSize: 40,buttonType: ButtonType.upImage, onPress: (){
                                AppPush.pushDefault(context, DriverAccountDetail());
                              })),
                              SizedBox(
                                height: 70.0,
                                width: 1,
                                child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.bgColor)),
                              ),
                              Expanded(child: AppButton(title: '账户充值',image: '司机中心-账户充值',imageSize: 40.0,buttonType: ButtonType.upImage, onPress: (){
                                AppPush.pushDefault(context, DriverRecharge());
                              })),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 15,bottom: 15),
                sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                      SliverModel model = dataList[index];
                      Border border = Border();
                      if(index<3){
                        switch(index%3){
                          case 1:{
                            border = Border(
                              left: BorderSide(color: AppColors.bgColor,width: 1),
                              right: BorderSide(color: AppColors.bgColor,width: 1),
                            );
                          }break;
                          default:{}break;
                        }
                      }else{
                        switch(index%3){
                          case 1:{
                            border = Border(
                              left: BorderSide(color: AppColors.bgColor,width: 1),
                              right: BorderSide(color: AppColors.bgColor,width: 1),
                              top: BorderSide(color: AppColors.bgColor,width: 1),
                            );
                          }break;
                          default:{
                            border = Border(
                              top: BorderSide(color: AppColors.bgColor,width: 1),
                            );
                          }break;
                        }
                      }
                      return InkWell(
                        onTap: (){
                          switch(index){
                            case 0:
                            case 1:
                            case 2:{//账户明细
                              AppPush.pushDefault(context, DriverAccountDetail());
                            }break;
                            case 3:
                            case 4:
                            case 5:{//月订单
                              AppPush.pushDefault(context, DriverOrderDetail(typeIndex: index-3,));
                            }break;
                            case 6:
                            case 7:
                            case 8:{//月积分
                              AppPush.pushDefault(context, DriverScoreDetail(typeIndex: index-6,));
                            }break;
                            case 9:
                            case 10:{//在线时长
                              AppPush.pushDefault(context, DriverOnlineTime(typeIndex: index-9,));
                            }break;
                            case 11:{//消单率
                              AppPush.pushDefault(context, DriverConsumptionRecord());
                            }break;
                            default:{}break;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          decoration: BoxDecoration(
                            border: border
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(child: AppText(text: model.title,color: AppColors.blackColor,fonSize: 13,)),
                              Expanded(child: AppBoldText(text: model.value,color: AppColors.mainColor,fonSize: 18,)),
                            ],
                          ),
                        ),
                      );
                    },childCount: dataList.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                      childAspectRatio: 1.8
                    )
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 100.0,
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      LoadAssetImage('司机中心-代驾分',radius: 0.0,),
                      InkWell(
                        onTap: (){
                          AppPush.pushDefault(context, DriverPointsRecord());
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16,right: 16,top: 15,bottom: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    height: 30.0,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child:LoadAssetImage('推广-驾驶',width: 18,fit: BoxFit.fitWidth,radius: 0.0,color: ColorsApp.whiteColor,),
                                        ),
                                        SizedBox(width: 5,),
                                        Expanded(child: Text('代驾分 ${AppClass.data(infoData, 'branch')}分',style: TextStyle(fontSize: 14,color: AppColors.whiteColor),))
                                      ],
                                    ),
                                  ),
                                  TextContainer(title: '本您度积分周期内扣完积分,系统将自动终止合作', height: 20, style: TextStyles.whiteAnd12),
                                  TextContainer(title: '戒指当前已扣${AppClass.data(infoData, 'dec_branch')}分', height: 20, style: TextStyles.whiteAnd12),
                                ],
                              )),
                              Container(
                                padding: EdgeInsets.only(top: 7),
                                width: 20.0,
                                child: Center(
                                  child: LoadAssetImage('ic_arrow_right', height: 15.0, width: 15.0,radius: 0.0,color: AppColors.whiteColor,),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SliverModel {

  String title;
  String value;

  SliverModel(this.title, this.value);


}