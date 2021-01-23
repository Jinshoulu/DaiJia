import 'package:demo/app_pages/order/OrderAccidentTreatment.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:flutter/material.dart';

class OrderSettlementDetail extends StatefulWidget {
  @override
  _OrderSettlementDetailState createState() => _OrderSettlementDetailState();
}

class _OrderSettlementDetailState extends State<OrderSettlementDetail> {

  double cellHeight = 45.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '订单结算详情',
      ),
      body: AppStackWidget(
          height: 191.0,
          topWidget: ListView(
            children: <Widget>[
              AppSizeBox(),
              Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: AppText(
                        text: '费用合计',
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
                                text: '¥ ',
                                style: TextStyle(
                                    fontSize: 14,
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
              AppSizeBox(),
              ContainerAddLineWidget(
                  height: cellHeight,
                  child: AppCell(title: '订单号', content: '20200612332132132131',height: cellHeight,)
              ),
              ContainerAddLineWidget(
                  height: cellHeight,
                  child: AppCell(title: '客户手机', content: '188545464',height: cellHeight,)
              ),
              ContainerAddLineWidget(
                  height: cellHeight,
                  child: AppCell(title: '起始地', content: '金成时代广场',height: cellHeight,)
              ),
              ContainerAddLineWidget(
                  height: cellHeight,
                  child: AppCell(title: '目的地', content: '冰河世纪',height: cellHeight,)
              ),
              AppSizeBox(),
              ContainerAddLineWidget(
                  height: cellHeight,
                  child: AppCell(title: '实际行驶里程', content: '12.03km',contentStyle: TextStyles.mainAnd12,height: cellHeight,)
              ),
              ContainerAddLineWidget(
                  height: cellHeight,
                  child: AppCell(title: '起步价', content: '25.00元',height: cellHeight,)
              ),
              ContainerAddLineWidget(
                  height: cellHeight,
                  child: AppCell(title: '里程费', content: '12.02元',height: cellHeight,)
              ),
              ContainerAddLineWidget(
                  height: cellHeight,
                  child: AppCell(title: '等候费', content: '10.00元',contentStyle: TextStyle(fontSize: 12,color: AppColors.red),height: cellHeight,)
              ),
              ContainerAddLineWidget(
                  height: cellHeight,
                  child: AppCell(title: '代金券', content: '5.00元',height: cellHeight,)
              ),
              AppSizeBox(height: 30.0,)
            ],
          ),
          downWidget: Container(
            child: Column(
              children: <Widget>[
                AppSizeBox(height: 1.0,),
                AppCell(title: '客户付款方式', content: '',height: cellHeight,),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  height: 80.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: SizedBox(
                        height: 40.0,
                        child: AppButton(title: '当面扫码支付',radius: 40.0,bgColor: AppColors.red,textStyle: TextStyles.whiteAnd14, onPress: (){
                          showMyQRImage();
                        }),
                      )),
                      SizedBox(width: 20,),
                      Expanded(child: SizedBox(
                        height: 40.0,
                        child: AppButton(title: '现金支付',radius: 40.0,bgColor: AppColors.mainColor,textStyle: TextStyles.whiteAnd14, onPress: (){

                        }),
                      ))
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.bgColor,width: 1))
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
                            buttonType: ButtonType.upImage,
                            onPress: () {
                              clickResult(0);
                            }),
                      ),
                      AppSizeBox(
                        width: 1,
                        height: 30.0,
                      ),
                      Expanded(
                        child: AppButton(
                            title: '事故处理',
                            image: '订单-事故处理',
                            imageSize: 20.0,
                            textStyle: TextStyle(fontSize: 12),
                            buttonType: ButtonType.upImage,
                            onPress: () {
                              clickResult(1);
                            }),
                      ),
                      AppSizeBox(
                        width: 1,
                        height: 30.0,
                      ),
                      Expanded(
                        child: AppButton(
                            title: '联系客服',
                            image: '订单-客服',
                            imageSize: 20.0,
                            textStyle: TextStyle(fontSize: 12),
                            buttonType: ButtonType.upImage,
                            onPress: () {
                              clickResult(2);
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
  
  showMyQRImage(){
    AppShowBottomDialog.showSheetQRImageDialog(this.context, (int index){
      clickResult(index);
    });
  }

  clickResult(int index){
    switch(index){
      case 0:{//紧急求助

      }break;
      case 1:{//事故处理
        AppPush.pushDefault(this.context, OrderAccidentTreatment());
      }break;
      default:{//客服

      }break;
    }
  }
}
