
import 'package:demo/app_pages/workbench/driverCenter/DriverCenter.dart';
import 'package:demo/app_pages/workbench/exchangeCenter/ExchangeCenter.dart';
import 'package:demo/app_pages/workbench/taskCenter/TaskCenter.dart';
import 'package:demo/app_pages/workbench/tools/custom_slider.dart';
import 'package:demo/app_pages/workbench/tools/home_address.dart';
import 'package:demo/app_pages/workbench/tools/home_header.dart';
import 'package:demo/app_pages/workbench/tools/home_submit_order_dialog.dart';
import 'package:demo/app_pages/workbench/tools/show_push_order_dialog.dart';
import 'package:demo/app_pages/workbench/tools/top_card_detail.dart';
import 'package:demo/app_pages/workbench/tools/top_center_menu.dart';
import 'package:demo/app_pages/workbench/tools/top_header.dart';
import 'package:demo/provider/app_status.dart';
import 'package:demo/z_tools/app_widget/app_clip_widget.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../public_header.dart';

class Workbench extends StatefulWidget {
  @override
  _WorkbenchState createState() => _WorkbenchState();
}

class _WorkbenchState extends State<Workbench> {


  ///数据列表
  List dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataList.add('value');
    dataList.add('value');
    dataList.add('value');
    dataList.add('value');
    dataList.add('value');


  }

  onRefreshData(){


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowEmptyBar(
        title: '标兵代驾',
        style: TextStyles.getBlackBoldText(16),
        leftWidget: AppButton(
          title: '派单返现',
          image: null,
          onPress: () {
            AppShowBottomDialog.showSendOrder(context, '派单必看', '知道了', Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              height: 250.0,
              child: Html(data: '这是派单必看的内容'),
            ), (){
              AppPush.push(context, HomeRouter.sendSingle);
            });
          },
        ),
        rightWidget: AppButton(
          title: '推广赚钱',
          image: null,
          onPress: () {
            AppPush.push(context, HomeRouter.pushMoneyAndScore);
          },
        ),
      ),
      body: AppStackWidget(
          height: 70,
          topWidget: EasyRefresh(child: CustomScrollView(
            slivers: <Widget>[
              //登录状态
              SliverToBoxAdapter(
                child: TopHeader(),
              ),
              //详情
              SliverToBoxAdapter(
                child: TopCardDetail(),
              ),
              //菜单
              SliverToBoxAdapter(
                child: TopCenterMenu(onPress: (index){
                  switch(index){
                    case 0:{//司机中心
                      AppPush.pushDefault(context, DriverCenter());
                    }break;
                    case 1:{//任务中心
                      AppPush.pushDefault(context, TaskCenter());
                    }break;
                    case 2:{//优推兑换
                      AppPush.pushDefault(context, ExchangeCenter());
                    }break;
                    default:{}break;
                  }
                }),
              ),
              //地图
              SliverToBoxAdapter(
                child: HomeAddress(
                    pushMap: (){

                    },
                    pushYuyue: (){

                    }
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10,),),
              SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return InkWell(
                  onTap: (){
//                    showModalBottomSheet(
//                        context: context,
//                        /// 使用true则高度不受16分之9的最高限制
//                        isScrollControlled: true,
//                        builder: (BuildContext context) {
//                          return DetermineWorkingStatus();
//                        }
//                    );
                    AppShowBottomDialog.showReloadLocal(context, '金成时代广场');

                  },
                  child: Container(
                    height: 50.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.bgColor,width: 1))
                    ),
                    margin: EdgeInsets.only(left: 16,right: 16),
                    child: Text('今日新郑积分今日新郑积分今日新郑积分今日新郑积分今日新郑积分今日新郑积分',style: TextStyles.blackAnd14,overflow: TextOverflow.ellipsis,),
                  ),
                );
              },childCount: dataList.length))

            ],
          )),
          downWidget: Container(
            padding: EdgeInsets.only(left: 16,right: 16),
            height: 70,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                CustomSlider(
                  totalWidth: MediaQuery.of(context).size.width-32-50-20,
                  height: 45.0,
                  successCallBack:(){
                    Toast.show('开始接单');
                    Future.delayed(Duration(seconds: 3)).then((value){
                      Provider.of<AppStatus>(context,listen: false).orderStatus=0;
                    });
                    showPushOrderWidget();
                  }
                ),
                SizedBox(width: 20.0,),
                AppClipWidget(
                    width: 45,
                    height: 45,
                    bgColor: AppColors.orangeColor,
                    child: AppButton(
                        buttonType: ButtonType.upImage,
                        title: '报单',
                        textStyle: TextStyle(fontSize: 10,color: AppColors.whiteColor),
                        image: '首页-报单',
                        imageSize: 15,
                        disW: 0.0,
                        textHeight: 14,
                        onPress: () {
                          showSubmitOrder();
                        }))
              ],
            ),
          )
      ),
    );
  }

  showSubmitOrder(){
    showModalBottomSheet(
      context: this.context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return HomeSubmitOrderDialog(
          btnPress: (){
            startService();
          },
        );
      },
    );
  }

  showPushOrderWidget(){
    double height = 35;
    showModalBottomSheet(
      context: this.context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ShowPushOrderDialog(
            btnPress: (int index){
             switch(index){
               case 0:{//接单
                  receivedOrder();
               }break;
               default:{//拒单
                  AppShowBottomDialog.showNormalDialog(context, '取消','确认','推送单局确认', '拒接推送单扣20分,并且降低2小时以内的接单权重,确认据接吗?', (){
                    requestRefuseOrder();
                  });
               }break;
             }
            },
        );
      },
    );
  }

  ///拒绝接单
  requestRefuseOrder(){

  }

  ///接单
  receivedOrder(){

  }

  ///开始服务
  startService(){

  }

}
