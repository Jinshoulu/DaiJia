
import 'package:demo/app_pages/order/OrderDeclaration.dart';
import 'package:demo/app_pages/order/OrderReported.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:flutter/material.dart';

import 'OrderSettlementDetail.dart';

class OrderConfirm extends StatefulWidget {
  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {

  double cellHeight = 50.0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '客户付款确认',
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            AppSizeBox(),
            Container(
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: AppText(
                      text: '本单收入',
                      color: AppColors.mainColor,
                    ),
                  ),
                  Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                              text: '+ ',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: '22.00',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold)),
                        ])),
                  )
                ],
              ),
            ),
            ContainerAddLineWidget(
                height: cellHeight,
                child: AppCell(title: '订单号', content: '20200612332132132131',height: cellHeight,)
            ),
            ContainerAddLineWidget(
                height: cellHeight,
                child: AppCell(title: '客户手机号', content: '18125367895',height: cellHeight,)
            ),
            ContainerAddLineWidget(
                height: cellHeight,
                child: AppCell(title: '代驾费', content: '50.0元',height: cellHeight,)
            ),
            ContainerAddLineWidget(
                height: cellHeight,
                child: AppCell(title: '本单收入', content: '22.00元',contentStyle: TextStyle(fontSize: 12,color: AppColors.red),height: cellHeight,)
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.only(left: 16,right: 16),
              height: 80.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: SizedBox(
                    height: 40.0,
                    child: AppButton(title: '我要报备',radius: 40.0,bgColor: AppColors.red,textStyle: TextStyles.whiteAnd14, onPress: (){
                      AppPush.pushDefault(context, OrderReported());
                    }),
                  )),
                  SizedBox(width: 20,),
                  Expanded(child: SizedBox(
                    height: 40.0,
                    child: AppButton(title: '确认并报单',radius: 40.0,bgColor: AppColors.mainColor,textStyle: TextStyles.whiteAnd14, onPress: (){
                      AppPush.pushDefault(context, OrderDeclaration());
                    }),
                  ))
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 40.0,
              child: AppButton(title: '选择收款方式',textStyle: TextStyle(fontSize: 14,color: AppColors.orangeColor), onPress:(){
                AppPush.pushDefault(context, OrderSettlementDetail());
              }),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
