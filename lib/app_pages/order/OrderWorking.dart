import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:demo/app_pages/driver/tools/MapClass.dart';
import 'package:demo/app_pages/order/OrderConfirm.dart';
import 'package:demo/app_pages/order/OrderDetail.dart';
import 'package:demo/provider/user_info.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/image/app_image_and_label.dart';
import 'package:demo/z_tools/image/image_header.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../public_header.dart';

class OrderWorking extends StatefulWidget {
  @override
  _OrderWorkingState createState() => _OrderWorkingState();
}

class _OrderWorkingState extends State<OrderWorking> with AutomaticKeepAliveClientMixin{
  ///进行中的订单的状态
  int orderStatus = 0;
  int millisecond = 0;
  Timer _timer;
  int hour = 0;
  int min = 0;
  int second = 0;
  int milli = 0;
  ///
  List<LatLng> coorsList = [];
  ///
  AmapController _controller;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coorsList.add(LatLng(34.777489, 113.708997));
    coorsList.add(LatLng(34.776489, 113.707997));
    coorsList.add(LatLng(34.776389, 113.706997));
    coorsList.add(LatLng(34.795489, 113.405997));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
    });

  }




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        Positioned(left: 0, top: 0, right: 0, child: showTopMapWidget()),
        Positioned(
            left: 0,
            top: orderStatus == 2 ? 150.0 : 250.0,
            right: 0,
            bottom: 0,
            child: showOrderInfoWidget()),
        Positioned(
            left: 0,
            top: orderStatus == 2 ? 120.0 : 220.0,
            right: 0,
            child: showCenterWidget()),
        Positioned(
            left: 0,top: 0,right: 0,
            child: Container(
              height: 50.0,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 100.0,
                    child: AppButton(title: '骑行', onPress: ()async{
                      await _controller?.clear();
                      ///获取骑行路线、距离和时长
                      MapClass.getRoutePath(_controller, coorsList.first, coorsList.last,(value)async{
                            await _controller?.addMarker(MarkerOption(
                                coordinate: coorsList.first,
                                visible: true,
                                iconProvider:
                                    AssetImage('assets/images/司机-忙碌.png'),
                                title: '您的位置',
                                snippet:
                                    '距离约：${value['distance']}km\n骑行时间: ${value['time']}分')
                            );
                            await _controller?.addMarker(MarkerOption(
                                coordinate: coorsList.last,
                                visible: true,
                                iconProvider:
                                    AssetImage('assets/images/派单-位置.png'),
                                title: '目的地',
                                snippet: '距离约：${value['distance']}km\n骑行时间: ${value['time']}分')
                            );
                          });
                    }),
                  ),
                  SizedBox(
                    width: 100.0,
                    child: AppButton(title: '驾车', onPress: (){
                      ///获取驾车路线、距离和时长
                      MapClass.getDriverPath(_controller, coorsList.first, coorsList.last,(value){
                        print(value);
                      });
                    }),
                  ),
                ],
              ),
            )
        )
      ],
    );
  }

  showTopMapWidget() {
    return Container(
      height: orderStatus == 2 ? 150.0 : 250.0,
      width: double.infinity,
      child: AmapView(
        mapType: ThemeUtils.isDark(context) ? MapType.Night : null,
        zoomLevel: 16,
        zoomGesturesEnabled: true,
        showZoomControl: false,
        autoRelease: false,
        onMapMoveEnd: (move) async {},
        onMapCreated: (controller) async {
          _controller = controller;
          await _controller?.showMyLocation(MyLocationOption(
            strokeColor: Colors.transparent,
            fillColor: Colors.blue.withOpacity(0.2),
            myLocationType: MyLocationType.Locate
          ));
          addMarkerOption(coorsList.first, coorsList.last);
        },
      ),
    );
  }

  addMarkerOption(LatLng startPoint,LatLng endPoint)async{
    await _controller?.addMarker(MarkerOption(
      coordinate: startPoint,
      visible: true,
      iconProvider: AssetImage('assets/images/司机-忙碌.png'),
      title: '您的位置',
      snippet: '预估时间: '

    ));
    await _controller?.addMarker(MarkerOption(
      coordinate: endPoint,
      visible: true,
      infoWindowEnabled: true,
      iconProvider: AssetImage('assets/images/派单-位置.png'),
      title: '目的地',
    ));
  }

  showOrderInfoWidget() {
    switch (orderStatus) {
      case 2: //驾驶结束
        {
          return showOrderInfoWidget1();
        }
        break;
      default: //0.前往客户位置 1.等待客户
        {
          return showOrderInfoWidget0();
        }
        break;
    }
  }

  startTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(milliseconds: 10), (value) {
        setState(() {
          millisecond = millisecond + 10;
          milli = millisecond % 1000 ~/ 10;
          second = millisecond ~/ 1000 % 60;
          min = millisecond / 1000 ~/ 60 % 60;
          hour = millisecond / 1000 ~/ 3600;
        });
      });
    }
  }

  ///中间的悬浮
  showCenterWidget() {
    switch (orderStatus) {
      case 1:
        {
          //等待客户
          return createCenter1();
        }
        break;
      case 2:
        {
          //驾驶结束
          return createCenter2();
        }
        break;
      default:
        {
          //前往客户位置
          return createCenter0();
        }
        break;
    }
  }

  //***************** 前往客户位置 ***********

  createCenter0() {
    return Card(
      shadowColor: AppColors.lightBlueColor,
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: 130.0,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: <Widget>[
            ContainerAddLineWidget(
                disW: 0.0,
                height: 40.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 35.0,
                        alignment: Alignment.center,
                        child: LoadAssetImage(
                          '订单-接驾中',
                          width: 15,
                          fit: BoxFit.fitHeight,
                          radius: 0.0,
                        ),
                      ),
                      Expanded(
                          child: AppText(
                            alignment: Alignment.centerLeft,
                            text: '接驾中(距离750m)',
                            color: AppColors.mainColor,
                          )),
                      SizedBox(
                          width: 90.0,
                          child: AppButton(
                              title: '订单详情',
                              image: 'ic_arrow_right',
                              imageSize: 10,
                              imageColor: AppColors.orangeColor,
                              textStyle: TextStyle(
                                  fontSize: 13, color: AppColors.orangeColor),
                              buttonType: ButtonType.rightImage,
                              onPress: () {
                                  AppPush.pushDefault(context, OrderDetail());
                              }))
                    ],
                  ),
                )),
            SizedBox(
              height: 10.0,
            ),
            AppImageAndLabel(
              height: 30.0,
              image: '订单-红色圆',
              imageSize: 10,
              title: '客户位置: 弧度攻速南门',
              showLine: false,
              showRightImage: false,
              onPress: () {},
            ),
            AppImageAndLabel(
              height: 40.0,
              image: '订单-蓝色圆',
              imageSize: 10,
              title: '客户电话: 17752521882',
              showLine: false,
              rightWidget: AppButton(
                  image: '订单-电话',
                  buttonType: ButtonType.onlyImage,
                  imageSize: 35.0,
                  onPress: () {
                    AppShowBottomDialog.showCallPhoneDialog(
                        '17752521882', this.context);
                  }),
              onPress: () {
                AppShowBottomDialog.showCallPhoneDialog(
                    '17752521882', this.context);
              },
            ),
          ],
        ),
      ),
    );
  }

  showOrderInfoWidget0() {
    return Container(
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SizedBox(),
          ),
          ContainerAddLineWidget(
              height: 35.0,
              child: orderStatus == 0
                  ? AppCell(title: '预计时间', content: '2分30秒')
                  : Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: Row(
                        children: <Widget>[
                          RichText(
                              text: TextSpan(
                                  text: '等待费用',
                                  style: TextStyle(
                                    fontSize: 14, color: AppColors.blackColor
                                  ),
                                  children: [
                                TextSpan(
                                    text: '（超过十分钟后，每分钟1元钱）',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.black54Color))
                              ])),
                          Expanded(
                            child: AppText(
                              alignment: Alignment.centerRight,
                              text: '0.00元',
                              color: AppColors.red,
                            ),
                          )
                        ],
                      ),
                  )),
          Container(
            height: 60.0,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: AppText(
                        alignment: Alignment.centerLeft,
                        text: orderStatus == 0 ? '实际已耗时' : '已等候时间')),
                Container(
                  alignment: Alignment.center,
                  child: RichText(
                      text: TextSpan(
                          text:
                              '${hour >= 10 ? '$hour' : '0$hour'}:${min >= 10 ? '$min' : '0$min'}:${second >= 10 ? '$second' : '0$second'}.',
                          style: TextStyle(
                              fontSize: 30,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: '${milli > 9 ? '$milli' : '0$milli'}',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.mainColor))
                      ])),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              height: 40.0,
              child: AppButton(
                  radius: 45.0,
                  bgColor: AppColors.mainColor,
                  title: orderStatus == 0 ? '已到达客户位置' : '启动车辆',
                  textStyle: TextStyles.whiteAnd14,
                  onPress: () {
                    if (orderStatus == 0) {
                      orderStatus = 1;
                      millisecond = 0;
                    } else {
                      millisecond = 0;
                      _timer.cancel();
                      _timer = null;
                      orderStatus = 2;
                    }
                    setState(() {});
                  }),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          createDownContainer()
        ],
      ),
    );
  }

  //***************** 正在等待客户 *************

  createCenter1() {
    return Card(
      shadowColor: AppColors.lightBlueColor,
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: 130.0,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: <Widget>[
            ContainerAddLineWidget(
                disW: 0.0,
                height: 40.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 35.0,
                        alignment: Alignment.center,
                        child: LoadAssetImage(
                          '订单-接驾中',
                          width: 15,
                          fit: BoxFit.fitHeight,
                          radius: 0.0,
                        ),
                      ),
                      Expanded(
                          child: AppText(
                            alignment: Alignment.centerLeft,
                            text: '等待客户中',
                            color: AppColors.mainColor,
                          )),
                      SizedBox(
                          width: 90.0,
                          child: AppButton(
                              title: '修改目的地',
                              image: 'ic_arrow_right',
                              imageSize: 10,
                              imageColor: AppColors.orangeColor,
                              textStyle: TextStyle(
                                  fontSize: 13, color: AppColors.orangeColor),
                              buttonType: ButtonType.rightImage,
                              onPress: () {}))
                    ],
                  ),
                )),
            SizedBox(
              height: 10.0,
            ),
            AppImageAndLabel(
              height: 30.0,
              image: '订单-红色圆',
              imageSize: 10,
              title: '客户目的地: 弧度攻速南门',
              showLine: false,
              showRightImage: false,
              onPress: () {},
            ),
            AppImageAndLabel(
              height: 40.0,
              image: '订单-蓝色圆',
              imageSize: 10,
              title: '客户电话: 17752521882',
              showLine: false,
              rightWidget: AppButton(
                  image: '订单-电话',
                  buttonType: ButtonType.onlyImage,
                  imageSize: 35.0,
                  onPress: () {
                    AppShowBottomDialog.showCallPhoneDialog(
                        '17752521882', this.context);
                  }),
              onPress: () {
                AppShowBottomDialog.showCallPhoneDialog(
                    '17752521882', this.context);
              },
            ),
          ],
        ),
      ),
    );
  }

  //***************** 驾驶结束 ***********

  createCenter2() {
    return Card(
      shadowColor: AppColors.lightBlueColor,
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: 200.0,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: <Widget>[
            Container(
              height: 30.0,
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  SizedBox(
                      width: 90.0,
                      child: AppButton(
                          title: '订单详情',
                          image: 'ic_arrow_right',
                          imageSize: 10,
                          imageColor: AppColors.mainColor,
                          textStyle: TextStyle(
                              fontSize: 13, color: AppColors.mainColor),
                          buttonType: ButtonType.rightImage,
                          onPress: () {

                            AppShowBottomDialog.showOrderDetailDialog(context, {});

                          }))
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
              child: AppText(
                text: '费用',
                color: AppColors.black54Color,
                fonSize: 12,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                          text: '¥ ',
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.red,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: '22.00',
                          style: TextStyle(
                              fontSize: 30,
                              color: AppColors.red,
                              fontWeight: FontWeight.bold)),
                    ])),
              ),
            ),
            AppSizeBox(
              height: 1,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10,),
                      AppImageAndLabel(
                        height: 30.0,
                        image: '订单-红色圆',
                        imageSize: 10,
                        title: '客户位置: 弧度攻速南门',
                        showLine: false,
                        showRightImage: false,
                        onPress: () {},
                      ),
                      AppImageAndLabel(
                        height: 30.0,
                        image: '订单-蓝色圆',
                        imageSize: 10,
                        title: '客户电话: 17752521882',
                        showLine: false,
                        showRightImage: false,
                        onPress: () {},
                      ),
                    ],
                  )),
                  Container(
                    width: 80.0,
                    child: AppButton(
                        image: '订单-电话',
                        imageSize: 35,
                        buttonType: ButtonType.onlyImage,
                        onPress: () {
                          AppShowBottomDialog.showCallPhoneDialog(
                              '17752521882', this.context);
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showOrderInfoWidget1() {
    double cellHeight = 30.0;
    return Container(
      color: AppColors.whiteColor,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 200.0,
          ),
          AppCell(
            title: '接驾耗时',
            content: '0分45秒',
            height: cellHeight,
            contentStyle: TextStyle(fontSize: 13, color: AppColors.mainColor),
          ),
          AppCell(
            title: '等待费用',
            content: '10.00元',
            height: cellHeight,
            contentStyle: TextStyle(fontSize: 13, color: AppColors.red),
          ),
          AppCell(
            title: '目的地',
            content: '陆辰广场北门100m',
            height: cellHeight,
          ),
          AppCell(
            title: '距离',
            content: '1.6km',
            height: cellHeight,
          ),
          AppCell(
            title: '已行驶里程',
            content: '0.68km',
            height: cellHeight,
          ),
          AppCell(
            title: '等候用时',
            content: '00:02:40',
            height: cellHeight,
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              height: 40.0,
              child: AppButton(
                  radius: 45.0,
                  bgColor: AppColors.mainColor,
                  title: '到达目的地',
                  textStyle: TextStyles.whiteAnd14,
                  onPress: () {
                    AppPush.pushDefault(context, OrderConfirm());
                  }),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          createDownContainer()
        ],
      ),
    );
  }

  createDownContainer() {
    return Container(
      height: 50.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: AppButton(
                title: '联系客服',
                image: '订单-客服',
                imageSize: 20.0,
                textStyle: TextStyle(fontSize: 12),
                buttonType: ButtonType.upImage,
                onPress: () {}),
          ),
          AppSizeBox(
            width: 1,
            height: 30.0,
          ),
          Expanded(
            child: AppButton(
                title: '取消订单',
                image: '订单-取消',
                imageSize: 20.0,
                textStyle: TextStyle(fontSize: 12),
                buttonType: ButtonType.upImage,
                onPress: () {}),
          ),
          AppSizeBox(
            width: 1,
            height: 30.0,
          ),
          Expanded(
            child: AppButton(
                title: '增派代驾员',
                image: '订单-增添代驾员',
                imageSize: 20.0,
                textStyle: TextStyle(fontSize: 12),
                buttonType: ButtonType.upImage,
                onPress: () {}),
          ),
        ],
      ),
    );
  }
}
