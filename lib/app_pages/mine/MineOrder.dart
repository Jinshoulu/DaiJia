
import 'package:demo/app_pages/order/OrderReported.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppBoldText.dart';
import 'package:demo/z_tools/app_widget/AppTabBar.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MineOrder extends StatefulWidget {
  @override
  _MineOrderState createState() => _MineOrderState();
}

class _MineOrderState extends State<MineOrder> with SingleTickerProviderStateMixin{
  
  PageController _pageController;

  List<String> titles = ['本月','上月','全部'];

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
        centerTitle: '订单列表',
      ),
      body: AppStackWidget(
          isUp: true,
          topWidget: AppTabBar(
              titles: titles,
              onTap: (int index){
                _pageController?.jumpToPage(index);
              }
          ),
          downWidget: PageView.builder(
              controller: _pageController,
              itemCount: titles.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context,int index){
                return OrderList(typeIndex: index);
              }
          )
      ),
    );
  }
}

class OrderList extends StatefulWidget {

  final int typeIndex;

  const OrderList({Key key,@required this.typeIndex}) : super(key: key);


  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {

    return AppRefreshWidget(
        itemBuilder: (BuildContext context, int index){
          return createContainer();
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

  createContainer(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
      color: AppColors.whiteColor,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: (){
              AppPush.pushDefault(context, OrderReported(orderId: '1',));
            },
              child: AppCell(
                title: '08-27 - - 09:27',
                content: '报备',
                contentStyle: TextStyles.mainAnd14,
              )
          ),
          AppSizeBox(height: 1,),
          SizedBox(height: 16,),
          Container(
            height: 70.0,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                      children: <Widget>[
                        subItem('派单-目的地', '', '进程时代广场'),
                        subItem('派单-目的地', '', '绿博园'),
                      ],
                    )
                ),
                SizedBox(
                  width: 100,
                  child: AppBoldText(text: '+52.00',color: AppColors.red,fonSize: 25,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  subItem(String image,String title, String content){
    return Container(
      height: 35.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 45.0,
            alignment: Alignment.center,
            child: LoadAssetImage(image,fit: BoxFit.fitWidth,width: 15,radius: 0.0,),
          ),
          Expanded(
              child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            style: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.blackColor),
                            text: title??''
                        ),
                        TextSpan(
                            style: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.blackColor),
                            text: ' '
                        ),
                        TextSpan(
                            style: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.blackColor),
                            text: content??''
                        ),
                      ]
                  )
              )
          )
        ],
      ),
    );

  }
}
