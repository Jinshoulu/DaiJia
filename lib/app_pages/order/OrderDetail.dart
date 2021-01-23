
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/image/image_header.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '订单详情',
      ),
      body: ListView(
        children: <Widget>[
          AppSizeBox(),
          Container(
            height: 180.0+32.0+32.0,
            padding: EdgeInsets.all(16),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                LoadAssetImage('订单-详情背景',radius: 0.0,),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppCell(
                        title: '订单号',
                        titleStyle: TextStyles.whiteAnd14,
                        content: '202000345646854',
                        contentStyle: TextStyles.whiteAnd14,
                        height: 35,
                      ),
                      Expanded(
                        child: Center(
                          child: ImageHeader(
                            height: 80,
                              image: 'defaultImage'
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                        width: double.infinity,
                        child: AppButton(
                            mainAxisAlignment: MainAxisAlignment.center,
                            title: '18425689347',
                            image: '登录手机',
                            textStyle: TextStyles.whiteAnd14,
                            imageSize: 15,
                            imageColor: AppColors.whiteColor,
                            buttonType: ButtonType.leftImage,
                            onPress: (){

                            }
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ContainerAddLineWidget(
              child: AppCell(
                title: '出发地',
                content: '金成时代广场',
                contentStyle: TextStyles.blackAnd14,
              )
          ),
          ContainerAddLineWidget(
              child: AppCell(
                title: '目的地',
                content: '碧沙岗公园',
                contentStyle: TextStyles.blackAnd14,
              )
          ),
          ContainerAddLineWidget(
              child: AppCell(
                title: '出发时间',
                content: '2020.02.12 14:12:21',
                contentStyle: TextStyles.blackAnd14,
              )
          ),
          ContainerAddLineWidget(
              child: AppCell(
                title: '服务结束时间',
                content: '2020.02.12 14:12:21',
                contentStyle: TextStyles.blackAnd14,
              )
          ),
          AppSizeBox(),
          ContainerAddLineWidget(
              child: AppCell(
                title: '实际里程',
                content: '11.25km',
                contentStyle: TextStyles.mainAnd14,
              )
          ),
          ContainerAddLineWidget(
              child: AppCell(
                title: '里程费',
                content: '24.50元',
                contentStyle: TextStyles.blackAnd14,
              )
          ),
          ContainerAddLineWidget(
              child: AppCell(
                title: '等候费',
                content: '50.00元',
                contentStyle: TextStyles.blackAnd14,
              )
          ),
          ContainerAddLineWidget(
              child: AppCell(
                title: '等待费',
                content: '3.50元',
                contentStyle: TextStyles.blackAnd14,
              )
          ),
          ContainerAddLineWidget(
              lineColor: AppColors.whiteColor,
              child: AppCell(
                title: '起步价',
                content: '4.52元',
                contentStyle: TextStyles.blackAnd14,
              )
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}
