
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:demo/z_tools/app_widget/AppBoldText.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/image/image_header.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

class DriverMap extends StatefulWidget {
  @override
  _DriverMapState createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> with SingleTickerProviderStateMixin, _AnimationMapMixin{

//  @override
//  // TODO: implement wantKeepAlive
//  bool get wantKeepAlive => true;

  //  定位的key
  GlobalKey anchorKey = GlobalKey();

  List<MarkerOption> markers = [];

  List<LatLng> coors = [];

  //上次点击的位置
  bool showMarker = false;
  LatLng selectLatLng;

  // 地图控制器
  AmapController _controller;

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coors.add(LatLng(34.777558 ,113.70906));
    coors.add(LatLng(34.777558, 113.70806));
    coors.add(LatLng(34.776558 ,113.70906));
    coors.add(LatLng(34.775558 ,113.70906));
    coors.add(LatLng(34.774558 ,113.70706));
    coors.add(LatLng(34.772558 ,113.70606));

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.clear();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {

//    super.build(context);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        AmapView(
          key: anchorKey,
          // 地图类型 (可选)
//          mapType: MapType.Bus,
          // 是否显示缩放控件 (可选)
          showZoomControl: false,
          // 是否显示指南针控件 (可选)
          showCompass: false,
          // 是否显示比例尺控件 (可选)
          showScaleControl: false,
          // 是否使能缩放手势 (可选)
          zoomGesturesEnabled: true,
          // 是否使能滚动手势 (可选)
          scrollGesturesEnabled: true,
          // 是否使能旋转手势 (可选)
          rotateGestureEnabled: false,
          // 是否使能倾斜手势 (可选)
          tiltGestureEnabled: false,
          // 缩放级别 (可选)
          zoomLevel: 16,
          onMapClicked: (LatLng latLng) async {
            print("我点击了===》${latLng.toString()}");
          },
          autoRelease: false,
          onMapMoveStart: (move)async{
            setState(() {
              showMarker = false;
            });
          },
          onMapMoveEnd: (move) async {
            if(selectLatLng!=null){
              setState(() {
                showMarker = true;
                selectLatLng = null;
              });
              _jumpController
                  .forward()
                  .then((it) => _jumpController.reverse());
            }

          },
          onMapCreated: (controller) async {
            _controller = controller;
            _controller.showLocateControl(true);
            await _controller?.showMyLocation(MyLocationOption(
              strokeColor: AppColors.mainColor,
              fillColor: AppColors.mainColor.withOpacity(0.2),
            ));
            _controller?.setMarkerClickedListener((marker)async{
              await marker.coordinate.then((value)async{
                selectLatLng = value;
                await _controller.setCenterCoordinate(value);
              });
            });
            addMarks();
          },
        ),
        Positioned(
          left: 0,top: 20,
            child: Container(
              width: 50,
              height: 50.0,
              child: IconButton(
                  icon: Icon(Icons.refresh,size: 35,),
                  onPressed: (){
                    _controller?.showMyLocation(MyLocationOption(
                    strokeColor: AppColors.mainColor,
                    fillColor: AppColors.mainColor.withOpacity(0.2),
                    ));
                    _controller.clear();
                    addMarks();
                  }
              ),
            )
        ),
        // 中心指示器
        showMarker?Center(
          child: AnimatedBuilder(
            animation: _tween,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  _tween.value.dx,
                  _tween.value.dy-45,
                ),
                child: child,
              );
            },
            child: driverUserInfoWidget(1),
          ),
        ):SizedBox(),
      ],
    );
  }

  addMarks()async{
    for(int i = 0;i<coors.length; i++){
      await _controller?.addMarker(MarkerOption(
        coordinate: coors[i],
        visible: true,
        iconProvider: AssetImage('assets/images/${driverImages[i%5]}.png'),
      ));
    }
  }

  List driverImages = ['司机-空闲','司机-报单','司机-忙碌','司机-离线','司机-选中',];

  driverUserInfoWidget(int index){
    Widget child = createSignContainer(index);
    return Container(
      width: 300,
      height: 80.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,right: 0,top: 0,bottom: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50.0,
                    alignment: Alignment.center,
                    child: ImageHeader(
                      image: driverImages[index],
                      height: 30.0,
                    ),
                  ),
                  Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Row(
                                  children: <Widget>[
                                    AppBoldText(text: '皮卡丘'),
                                    SizedBox(width: 5,),
                                    child,
                                    Expanded(
                                        child: AppText(
                                          alignment: Alignment.centerRight,
                                          text: '50m',
                                          fonSize: 12,
                                          color: AppColors.black54Color,
                                        )
                                    )
                                  ],
                                ),
                              )
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: AppText(
                                          color: AppColors.black54Color,
                                          alignment: Alignment.centerLeft,
                                          text: '代驾: 155次',
                                          fonSize: 12,
                                        )
                                    ),
                                    Expanded(
                                        child: AppText(
                                          color: AppColors.black54Color,
                                          alignment: Alignment.centerLeft,
                                          text: '驾龄: 11年',
                                          fonSize: 12,
                                        )
                                    ),
                                    InkWell(
                                      onTap: (){
                                        AppShowBottomDialog.showCallPhoneDialog('188569324568', context);
                                      },
                                      child: Container(
                                        width: 30.0,
                                        alignment: Alignment.center,
                                        child: ImageHeader(
                                          height: 30,
                                          image: '订单-电话',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,left: 0,right: 0,
            child: Container(
              height: 10.0,
              alignment: Alignment.center,
              child: LoadAssetImage('向下三角',width: 10,height: 10,color: AppColors.whiteColor,radius: 0.0,),
            ),
          ),
        ],
      ),
    );
  }
  
  createSignContainer(int index){
    Widget child;
    switch(index){
      case 0:{
        child = Container(
          width: 40.0,
          height: 20.0,
          alignment: Alignment.center,
          child: Text('忙碌',style: TextStyles.whiteAnd12,),
          decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.all(Radius.circular(2.0))
          ),
        );
      }break;
      case 1:{
        child = Container(
          width: 40.0,
          height: 20.0,
          alignment: Alignment.center,
          child: Text('空闲',style: TextStyles.whiteAnd12,),
          decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.all(Radius.circular(2.0))
          ),
        );
      }break;
      default:{
        child = Container(
          width: 40.0,
          height: 20.0,
          alignment: Alignment.center,
          child: Text('下班',style: TextStyles.whiteAnd12,),
          decoration: BoxDecoration(
              color: AppColors.black54Color,
              borderRadius: BorderRadius.all(Radius.circular(2.0))
          ),
        );
      }break;
    }
    return child;
  }

}

mixin _AnimationMapMixin on SingleTickerProviderStateMixin<DriverMap> {
  // 动画相关
  AnimationController _jumpController;
  Animation<Offset> _tween;

  @override
  void initState() {
    super.initState();
    _jumpController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _tween = Tween(begin: Offset(0, 0), end: Offset(0, -40)).animate(
        CurvedAnimation(parent: _jumpController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _jumpController?.dispose();
    super.dispose();
  }
}
