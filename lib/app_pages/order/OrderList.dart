
import 'package:demo/z_tools/app_widget/AppBoldText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

class OrderList extends StatefulWidget {

  final int typeIndex;

  const OrderList({Key key,@required this.typeIndex}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List dataList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          AppCell(title: '订单号: 2020202012454654654', content: ''),
          AppSizeBox(height: 1,),
          SizedBox(height: 16,),
          Container(
            height: 105,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                      children: <Widget>[
                        subItem('派单-目的地', '出发地:', '进程时代广场'),
                        subItem('派单-目的地', '目的地:', '绿博园'),
                        subItem('订单-手机', '客户电话:', '15138670377'),
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
