
import 'package:demo/app_pages/workbench/beans/HomePushScoreBean.dart';
import 'package:demo/app_pages/workbench/push/create_order_scan.dart';
import 'package:demo/app_pages/workbench/push/push_qr_code.dart';
import 'package:demo/app_pages/workbench/push/push_tags.dart';
import 'package:demo/app_pages/workbench/single/MakeMoneyRecord.dart';
import 'package:demo/app_pages/workbench/single/RewardSystem.dart';
import 'package:demo/app_pages/workbench/single/StrategiesToMakeMoney.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/material.dart';

class PushMoneyAndScore extends StatefulWidget {
  @override
  _PushMoneyAndScoreState createState() => _PushMoneyAndScoreState();
}

class _PushMoneyAndScoreState extends State<PushMoneyAndScore> {


  HomePushScoreBean scoreBean;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    getData();
  }

  //读取缓存
  readData(){
    AppClass.readData(Api.homeGetPushIntegralUrl).then((value){
      if(value!=null){
        setState(() {
          scoreBean = HomePushScoreBean.fromJson(value);
        });
      }
    });
  }

  //获取最新信息
  getData(){
    DioUtils.instance.post(Api.homeGetPushIntegralUrl,onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.homeGetPushIntegralUrl);
        if(mounted){
          setState(() {
            scoreBean = HomePushScoreBean.fromJson(response);
          });
        }
      }
    },onFailure: (code,msg){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowWhiteAppBar(
        centerTitle: '推广赚钱和积分',
      ),
      body: AppStackWidget(
          isUp: true,
          height: 120.0,
          topWidget: Container(
            height: 120.0,
            margin: EdgeInsets.only(top: 10.0),
            color: ColorsApp.whiteColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AppButton(buttonType: ButtonType.upImage,title: '奖励机制',imageSize: 45, image: '首页-奖励机制', onPress: (){
                    AppPush.pushDefault(context, RewardSystem());
                  }),
                ),
                Expanded(
                  child: AppButton(buttonType: ButtonType.upImage,title: '赚钱攻略',imageSize: 45, image: '首页-赚钱攻略', onPress: (){
                    AppPush.pushDefault(context, StategoesToMakeMoney());
                  }),
                ),
                Expanded(
                  child: AppButton(buttonType: ButtonType.upImage,title: '赚钱记录',imageSize: 45, image: '首页-赚钱记录', onPress: (){
                    AppPush.pushDefault(context, MakeMoneyRecord());
                  }),
                ),
              ],
            ),
          ),
          downWidget: Container(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 10,child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.bgColor)),),
                scoreBean?.push_user==0?SizedBox():createCell(0,'红包推广卡，最高优惠可达100元，先领券后下单',RichText(overflow: TextOverflow.ellipsis,text: TextSpan(
                  style: TextStyle(fontSize: 12,color: AppColors.black54Color),
                  children: [
                    TextSpan(
                      text: '奖'
                    ),
                    TextSpan(
                        text: scoreBean?.push_user.toString()=='null'?'':scoreBean?.push_user.toString(),
                      style: TextStyle(fontSize: 12,color: AppColors.orangeColor)
                    ),
                    TextSpan(
                        text: '积分,新客下单奖优推一个(下单优先推给您)'
                    )
                  ]
                ))),
                scoreBean?.share_user==0?SizedBox():createCell(1,'分享到微信',RichText(overflow: TextOverflow.ellipsis,text: TextSpan(
                    style: TextStyle(fontSize: 12,color: AppColors.black54Color),
                    children: [
                      TextSpan(
                          text: '奖'
                      ),
                      TextSpan(
                          text: scoreBean?.share_user.toString()=='null'?'':scoreBean?.share_user.toString(),
                          style: TextStyle(fontSize: 12,color: AppColors.orangeColor)
                      ),
                      TextSpan(
                          text: '积分,新客下单奖优推一个(下单优先推给您)'
                      )
                    ]
                ))),
                scoreBean?.cre_order==0?SizedBox():createCell(2,'推荐客户扫码开单',RichText(overflow: TextOverflow.ellipsis,text: TextSpan(
                    style: TextStyle(fontSize: 12,color: AppColors.black54Color),
                    children: [
                      TextSpan(
                          text: '奖'
                      ),
                      TextSpan(
                          text: scoreBean?.cre_order.toString()=='null'?'':scoreBean?.cre_order.toString(),
                          style: TextStyle(fontSize: 12,color: AppColors.orangeColor)
                      ),
                      TextSpan(
                          text: '积分,新客下单奖优推一个(下单优先推给您)'
                      )
                    ]
                ))),
                scoreBean?.push_dri==0?SizedBox():createCell(3,'推荐司机入职标兵代驾',RichText(overflow: TextOverflow.ellipsis,text: TextSpan(
                    style: TextStyle(fontSize: 12,color: AppColors.black54Color),
                    children: [
                      TextSpan(
                          text: '成功入职奖'
                      ),
                      TextSpan(
                          text: scoreBean?.push_dri.toString()??'',
                          style: TextStyle(fontSize: 12,color: AppColors.orangeColor)
                      ),
                      TextSpan(
                          text: '积分'
                      )
                    ]
                ))),
              ],
            ),

//            child: new PageView(
//              controller: _pageController,
//              physics: NeverScrollableScrollPhysics(),
//              onPageChanged: (index){},
//              children: <Widget>[
//                new MoneyAndScorePage()
//              ],
//            ),
          )
      ),
    );
  }

  createCell(int index, String title,Widget child){
    return InkWell(
      onTap: (){
        switch(index){
          case 0:{//推广
            AppPush.pushDefault(this.context, PushTags());
          }break;
          case 1:{//分享
            AppShowBottomDialog.showShare(this.context);
          }break;
          case 2:{//扫码开单
            AppPush.pushDefault(this.context, CreateOrderScan());
          }break;
          case 3:{//推荐代叫商家
            AppPush.pushDefault(this.context, PushQrCode());
          }break;
          default:{}break;
        }
      },
      child: ContainerAddLineWidget(
          height: 70,
          edgeInsets: EdgeInsets.only(),
          disW: 0.0,
          child: Container(
            padding: EdgeInsets.only(left: 16,right: 10,top: 5,bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(title,style: TextStyles.blackAnd14,),
                      ),
                    ),
                    Expanded(child: Container(
                      alignment: Alignment.centerLeft,
                      child: child,
                    ))
                  ],
                )),
                Container(
                  width: 20.0,
                  child: Center(
                    child: LoadAssetImage('ic_arrow_right', height: 15.0, width: 15.0,radius: 0.0,color: AppColors.black54Color,),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

}


class MoneyAndScorePage extends StatefulWidget {
  @override
  _MoneyAndScorePageState createState() => _MoneyAndScorePageState();
}

class _MoneyAndScorePageState extends State<MoneyAndScorePage> {

  List dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshWidget(
        itemBuilder: (BuildContext context, int index){
          return ContainerAddLineWidget(
            height: 60,
              child: Container(
                padding: EdgeInsets.only(top: 5,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('推荐客户扫码开单',style: TextStyles.blackAnd14,),
                          ),
                        ),
                        Expanded(child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('讲10积分，新客户下单优推一个',style: TextStyles.textDarkGray14,),
                        ))
                      ],
                    )),
                    Container(
                      width: 20.0,
                      child: Center(
                        child: LoadAssetImage('ic_arrow_right', height: 15.0, width: 15.0,radius: 0.0,color: AppColors.black54Color,),
                      ),
                    )
                  ],
                ),
              )
          );
        },
        requestData: {},
        requestUrl: Api.baseApi,
        requestBackData: (List list){
          setState(() {
            dataList = list;
          });
        }
    );
  }
}
