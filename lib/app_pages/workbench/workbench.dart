
import 'package:demo/app_pages/map/selectMap/AmapLocationAndSelectLocationPage.dart';
import 'package:demo/app_pages/workbench/appointment/Appointment.dart';
import 'package:demo/app_pages/workbench/beans/HomeInfoBean.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverCenter.dart';
import 'package:demo/app_pages/workbench/exchangeCenter/ExchangeCenter.dart';
import 'package:demo/app_pages/workbench/single/BackMoneyNoticeList.dart';
import 'package:demo/app_pages/workbench/single/OrderNoticeList.dart';
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
import 'package:demo/provider/user_info.dart';
import 'package:demo/z_tools/app_bus_event.dart';
import 'package:demo/z_tools/app_value.dart';
import 'package:demo/z_tools/app_widget/app_clip_widget.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/router/routers.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../public_header.dart';

class Workbench extends StatefulWidget {
  @override
  _WorkbenchState createState() => _WorkbenchState();
}

class _WorkbenchState extends State<Workbench> with AutomaticKeepAliveClientMixin{


  ///公告
  List<Noticelist> dataList_adment = [];
  List dataList_backNotice = [];
  List dataList_orderNotice = [];
  //首页类型 0.公司公告 1.返现提醒 2.订单提醒
  int type = 0;

  HomeInfoBean infoBean;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readHomeData();
    onRefreshData();
  }

  ///读取保存的数据
  readHomeData(){
    AppClass.readData(Api.homeInfoUrl).then((value){
      if(value!=null){
        setState(() {
          infoBean = HomeInfoBean.fromJson(value);
          dataList_adment = infoBean.noticelist;
        });
      }
    });
//    AppClass.readData(Api.homeInfoUrl).then((value){
//      if(value!=null){
//        setState(() {
//          dataList_backNotice = value;
//        });
//      }
//    });
    AppClass.readData(Api.mineOrderTipsUrl).then((value){
      if(value!=null){
        setState(() {
          dataList_orderNotice = value;
        });
      }
    });
  }

  //刷新
  onRefreshData(){
    getHomeData();

  }

  ///获取首页信息
  getHomeData(){
    DioUtils.instance.post(Api.homeInfoUrl,onSucceed: (response){
      if(response is Map){
        if(mounted){
          AppClass.saveData(response, Api.homeInfoUrl);
          infoBean = HomeInfoBean.fromJson(response);
          setState(() {});
        }
      }
    },onFailure: (code,msg){

    });

  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    super.build(context);

    return Scaffold(
      appBar: ShowEmptyBar(
        title: '标兵代驾',
        style: TextStyles.getBlackBoldText(16),
        leftWidget: AppButton(
          title: '派单返现',
          image: null,
          onPress: () {
            AppPush.push(context, HomeRouter.sendSingle);
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
                child: TopHeader(
                  bean: infoBean,
                ),
              ),
              //详情
              SliverToBoxAdapter(
                child: TopCardDetail(
                  bean: infoBean,
                ),
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
                      AppPush.pushDefaultResult(context, AmapLocationAndSelectLocationPage(),(data){
                        print(data);
                      });
                    },
                    pushYuyue: (){
                      AppPush.pushDefault(context, Appointment());
                    }
                )
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10,),),
              SliverToBoxAdapter(
                child: HomeHeader(
                  bean: infoBean,
                  type: type,
                  onPress: (value){
                    switch(value){
                      case '公司公告':{
                        type = 0;
                      }break;
                      case '返现提醒':{
                        type = 1;
                      }break;
                      case '订单提醒':{
                        type = 2;
                      }break;
                      case '查看更多':{
                        if(type==1){
                          AppPush.pushDefaultResult(context, BackMoneyNoticeList(),(ret){
                            getHomeData();
                          });
                        }else{
                          AppPush.pushDefaultResult(context, OrderNoticeList(),(ret){
                            getHomeData();
                          });
                        }
                      }break;
                      default:{}break;
                    }
                    setState(() {});
                  },
                ),
              ),
              createHomeListData()
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

  createHomeListData(){
    switch(type){
      case 0:
        {
          //公司公告
          return dataList_adment.length == 0
              ? SliverToBoxAdapter(
                  child: Container(
                      height: MediaQuery.of(context).size.width,
                      child: StateLayout(
                          type:StateType.empty)),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        Noticelist noticelist = dataList_adment[index];
                  return InkWell(
                    onTap: () {
                      AppShowBottomDialog.showReloadLocal(context, Provider.of<UserInfo>(context).user_aoi_name??'');
                    },
                    child: Container(
                      height: 50.0,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.bgColor, width: 1))),
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        noticelist?.title??'',
                        style: TextStyles.blackAnd14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }, childCount: dataList_adment.length));
        }
        break;
      case 1:
        {
          //返现提醒
          return dataList_backNotice.length == 0
              ? SliverToBoxAdapter(
                  child: Container(
                      height: MediaQuery.of(context).size.width,
                      child: StateLayout(type: StateType.empty)),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      AppShowBottomDialog.showReloadLocal(context,
                          Provider.of<UserInfo>(context).user_aoi_name ?? '');
                    },
                    child: Container(
                      height: 50.0,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.bgColor, width: 1))),
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        AppClass.data(dataList_backNotice[index], 'key'),
                        style: TextStyles.blackAnd14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }, childCount: dataList_backNotice.length));
        }
        break;
      case 2:
        {
          //订单提醒
          return dataList_orderNotice.length == 0
              ? SliverToBoxAdapter(
                  child: Container(
                      height: MediaQuery.of(context).size.width,
                      child: StateLayout(type: StateType.empty)),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      AppShowBottomDialog.showReloadLocal(context,
                          Provider.of<UserInfo>(context).user_aoi_name ?? '');
                    },
                    child: Container(
                      height: 50.0,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.bgColor, width: 1))),
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        AppClass.data(dataList_orderNotice[index], 'key'),
                        style: TextStyles.blackAnd14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }, childCount: dataList_orderNotice.length));
        }
        break;
      default:
        {}
        break;
    }
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

    eventBus.fire(PlayerAudio('message.mp3'));

  }

  ///开始服务
  startService(){

  }

}
