
import 'package:demo/app_pages/workbench/push/push_qr_code.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppBoldText.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/material.dart';

class MakeMoneyRecordCopy extends StatefulWidget {
  @override
  _MakeMoneyRecordCopyState createState() => _MakeMoneyRecordCopyState();
}

class _MakeMoneyRecordCopyState extends State<MakeMoneyRecordCopy> {

  PageController _pageController = new PageController();
  int mSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '赚钱记录',
        rightWidget: AppButton(title: '代叫推广码',textStyle: TextStyle(fontSize: 13,color: AppColors.mainColor), onPress: (){
          AppPush.pushDefault(context, PushQrCode());
        }),
      ),
      body: AppStackWidget(
          isUp: true,
          height: 272.0,
          topWidget: Container(
            height: 272.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16,top: 16,right: 16),
                  height: 130.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      LoadAssetImage('赚钱记录卡片',radius: 0.0,),
                      Container(
                        padding: EdgeInsets.only(top: 30,bottom: 30),
                        child: Row(
                          children: <Widget>[
                            createHeaderItem('999.99', '总收入(元)'),
                            createHeaderItem('999.99', '邀请用户数量'),
                            createHeaderItem('999.99', '总订单数量'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            setState(() {
                              mSelected=0;
                              _pageController?.jumpToPage(mSelected);
                            });
                          },
                          child: Container(
                            width: 120.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),bottomLeft:Radius.circular(40.0)),
                              border: Border.all(color: AppColors.mainColor,width: 1),
                              color: mSelected==0?AppColors.mainColor:AppColors.whiteColor
                            ),
                            child: AppText(text: '邀请用户',color: mSelected==0?AppColors.whiteColor:AppColors.mainColor,),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              mSelected=1;
                              _pageController?.jumpToPage(mSelected);
                            });
                          },
                          child: Container(
                            width: 120.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(40.0),bottomRight:Radius.circular(40.0)),
                                border: Border.all(color: AppColors.mainColor,width: 1),
                                color: mSelected==1?AppColors.mainColor:AppColors.whiteColor
                            ),
                            child: AppText(text: '成功订单',color: mSelected==1?AppColors.whiteColor:AppColors.mainColor,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                mSelected==0?Container(
                  height: 40.0,
                  color: AppColors.lightBlueColor,
                  child: Row(
                    children: <Widget>[
                      Expanded(flex: 1,child: AppText(text: '注册时间',color: AppColors.mainColor,fonSize: 13,)),
                      Expanded(flex: 1,child: AppText(text: '手机号',color: AppColors.mainColor,fonSize: 13,)),
                      Expanded(flex: 1,child: AppText(text: '订单量',color: AppColors.mainColor,fonSize: 13,)),
                      Expanded(flex: 1,child: AppText(text: '类型',color: AppColors.mainColor,fonSize: 13,)),
                    ],
                  ),
                ):Container(
                  height: 40.0,
                  color: AppColors.lightBlueColor,
                  child: Row(
                    children: <Widget>[
                      Expanded(flex: 2,child: AppText(text: '订单时间/被邀请人',color: AppColors.mainColor,fonSize: 13,)),
                      Expanded(flex: 1,child: AppText(text: '类型',color: AppColors.mainColor,fonSize: 13,)),
                      Expanded(flex: 1,child: AppText(text: '积分',color: AppColors.mainColor,fonSize: 13,)),
                      Expanded(flex: 1,child: AppText(text: '返利',color: AppColors.mainColor,fonSize: 13,)),
                    ],
                  ),
                )
              ],
            ),
          ),
          downWidget: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index){
              debugPrint("当前索引：" + index.toString());
              mSelected = index;
              if (mounted) {
                setState(() {});
              }
            },
            children: <Widget>[
              new InviteUser(),
              new OrderSuccess()
            ],
          )
      ),
    );
  }

  createHeaderItem(String value,String title){
    return Expanded(child: Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: AppBoldText(text: value,color: AppColors.whiteColor,fonSize: 20,)
          ),
          Expanded(
              child: AppText(text: title,color: AppColors.whiteColor,fonSize: 12,)
          )
        ],
      ),
    ));
  }
}

class InviteUser extends StatefulWidget {
  @override
  _InviteUserState createState() => _InviteUserState();
}

class _InviteUserState extends State<InviteUser> {

  List dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshWidget(
        itemBuilder: (BuildContext context, int index){
          return ContainerAddLineWidget(
            edgeInsets: EdgeInsets.only(left: 0,right: 0),
              child: Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    createContainer(1, Text('2020.12.12',style: TextStyle(fontSize: 12,color: AppColors.blackColor),)),
                    createContainer(1, Text('15136842366',style: TextStyle(fontSize: 12,color: AppColors.blackColor),)),
                    createContainer(1, Text('99999',style: TextStyle(fontSize: 12,color: AppColors.blackColor),)),
                    createContainer(1, Text('标兵代驾',style: TextStyle(fontSize: 12,color: AppColors.red),)),
                  ],
                ),
              )
          );
        },
        requestData: {},
        requestUrl: Api.registerUrl,
        requestBackData: (List list){
          setState(() {
            dataList = list;
          });
        }
    );
  }
  
  createContainer(int size,Widget text){
    return Expanded(
      flex: size,
        child: Container(
          alignment: Alignment.center,
          child: text,
        )
    );
  }
}


class OrderSuccess extends StatefulWidget {
  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  List dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshWidget(
        itemBuilder: (BuildContext context, int index){
          return ContainerAddLineWidget(
              edgeInsets: EdgeInsets.only(left: 0,right: 0),
              child: Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    createContainer(2, Text('2020.12.12',style: TextStyle(fontSize: 12,color: AppColors.blackColor),)),
                    createContainer(1, Text('标兵代驾',style: TextStyle(fontSize: 12,color: AppColors.red),)),
                    createContainer(1, Text('99999',style: TextStyle(fontSize: 12,color: AppColors.blackColor),)),
                    createContainer(1, Text('99999',style: TextStyle(fontSize: 12,color: AppColors.blackColor),)),
                  ],
                ),
              )
          );
        },
        requestData: {},
        requestUrl: Api.registerUrl,
        requestBackData: (List list){
          setState(() {
            dataList = list;
          });
        }
    );
  }

  createContainer(int size,Widget text){
    return Expanded(
        flex: size,
        child: Container(
          alignment: Alignment.center,
          child: text,
        )
    );
  }
}

