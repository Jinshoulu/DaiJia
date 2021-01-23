
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class OrderDetailDialog extends StatefulWidget {
  final Map data;

  const OrderDetailDialog({Key key, this.data}) : super(key: key);

  @override
  _OrderDetailDialogState createState() => _OrderDetailDialogState();
}

class _OrderDetailDialogState extends State<OrderDetailDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: AppColors.whiteColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextContainer(
                  alignment: Alignment.center,
                  showBottomSlide: true,
                  slideColor: AppColors.black54Color,
                  title: '订单详情',
                  height: 60,
                  style: TextStyle(fontSize: 18,color: AppColors.blackColor)
              ),
              SizedBox(height: 10,),
              AppCell(title: '出发地', content: '爱因斯坦称',leftWidget: Container(
                width: 20.0,
                alignment: Alignment.center,
                child: LoadAssetImage('订单-目的地',width: 20,fit: BoxFit.fitWidth,radius: 0.0,),
              ),height: 45,),
              AppCell(title: '目的地', content: '绿城购机',leftWidget: Container(
                width: 20.0,
                alignment: Alignment.center,
                child: LoadAssetImage('订单-目的地',width: 20,fit: BoxFit.fitWidth,radius: 0.0,),
              ),height: 45,),
              AppCell(title: '客户电话', content: '15636899547',leftWidget: Container(
                width: 20.0,
                alignment: Alignment.center,
                child: LoadAssetImage('登录手机',width: 20,fit: BoxFit.fitWidth,radius: 0.0,),
              ),height: 45,),
              AppCell(title: '订单预约时间', content: '2020.01.25 12.12.12',height: 45,),
              AppCell(title: '预约里程', content: '16.2km',contentStyle: TextStyle(fontSize: 12,color: AppColors.mainColor),height: 45,),
              AppCell(title: '预计费用', content: '22.00元',contentStyle: TextStyle(fontSize: 12,color: AppColors.red),height: 45.0,),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                height: 100.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: SizedBox(
                      height: 45.0,
                      child: AppButton(title: '联系客户',radius: 40.0,bgColor: AppColors.red,textStyle: TextStyles.whiteAnd14, onPress: (){
                          Navigator.pop(context);
                          AppShowBottomDialog.showCallPhoneDialog('15151353545', context);
                      }),
                    )),
                    SizedBox(width: 20,),
                    Expanded(child: SizedBox(
                      height: 45.0,
                      child: AppButton(title: '我知道了',radius: 40.0,bgColor: AppColors.mainColor,textStyle: TextStyles.whiteAnd14, onPress: (){
                        Navigator.pop(context);
                      }),
                    ))
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
