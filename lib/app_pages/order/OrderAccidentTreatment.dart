
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class OrderAccidentTreatment extends StatefulWidget {
  @override
  _OrderAccidentTreatmentState createState() => _OrderAccidentTreatmentState();
}

class _OrderAccidentTreatmentState extends State<OrderAccidentTreatment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '事故处理',
      ),
      body: AppStackWidget(
          topWidget: createTopWidget(),
          downWidget: createDownWidget()
      ),
    );
  }

  createTopWidget(){
    return Container(
      child: Column(
        children: <Widget>[
          AppCell(title: '公司电话', content: '0755-25256666'),
          AppCell(title: '急救电话', content: '120'),
          AppCell(title: '事故处理电话', content: '122',contentStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),),
          AppCell(title: '保险公司报案电话', content: '655323'),
          AppCell(title: '总部备案号码', content: '010-25256666'),
          AppSizeBox(),
          Expanded(
              child: Html(
                  data: '事故处理流程'
              )
          )
        ],
      ),
    );
  }

  createDownWidget(){

    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.black33Color,width: 1))
      ),
      height: 50.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: AppButton(
                title: '紧急求助',
                image: '订单-紧急求助',
                imageSize: 20.0,
                textStyle: TextStyle(fontSize: 12),
                disW: 0,
                buttonType: ButtonType.upImage,
                onPress: () {}),
          ),
          AppSizeBox(
            width: 1,
            color: AppColors.black33Color,
            height: 30.0,
          ),
          Expanded(
            child: AppButton(
                title: '事故处理',
                image: '订单-事故处理',
                imageSize: 20.0,
                textStyle: TextStyle(fontSize: 12),
                disW: 0,
                buttonType: ButtonType.upImage,
                onPress: () {}),
          ),
          AppSizeBox(
            width: 1,
            color: AppColors.black33Color,
            height: 30.0,
          ),
          Expanded(
            child: AppButton(
                title: '取消订单',
                image: '订单-取消',
                imageSize: 20.0,
                textStyle: TextStyle(fontSize: 12),
                disW: 0,
                buttonType: ButtonType.upImage,
                onPress: () {}),
          ),
        ],
      ),
    );
  }
}
