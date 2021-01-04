
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';

class AmapLocationRoute extends StatefulWidget {
  @override
  _AmapLocationRouteState createState() => _AmapLocationRouteState();
}

class _AmapLocationRouteState extends State<AmapLocationRoute> {

  AmapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('展示地图'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              height: 300.0,
              child: AmapView(
                mapType: MapType.Satellite,
                showZoomControl: false,
                tilt: 60,
                zoomLevel: 17,
                centerCoordinate: LatLng(29, 119),
                maskDelay: Duration(milliseconds: 500),
                onMapCreated: (controller) async {
                  _controller = controller;
                  _controller?.setMapLanguage(Language.Chinese);//显示语言
//                  _controller?.setMapType(MapType.Standard);//正常视图
                  _controller?.setMapType(MapType.Navi);//导航视图
                  _controller?.showTraffic(true);//是否显示路况
                  showCurrentLocal();
                },
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[

                    ],
                  ),
                )
            )

          ],
        ),
      ),
    );
  }

  showCurrentLocal () async {
    await _controller?.showMyLocation(MyLocationOption(
        show: true,//是否显示定位
        iconProvider: AssetImage('assets/images/test_icon.png'),//定位图片
        myLocationType: MyLocationType.Rotate,//定位模式 - - 当前属于连续定位跟随方向模式
        interval: Duration(seconds: 5)//定位刷新间隔时间
    ));
    //获取当前坐标
    final latLng = await _controller?.getLocation();
    print('long = ${latLng.longitude}, late= ${latLng.latitude}');
    //获取中心位置坐标
    final center = await _controller?.getCenterCoordinate();
    print('center: lat: ${center.latitude}, lng: ${center.longitude}');
  }

  listenerMove(){
    _controller?.setMapMoveListener(
      onMapMoveStart: (move) async => debugPrint('开始移动: $move'),
      onMapMoving: (move) async => debugPrint('移动中: $move'),
      onMapMoveEnd: (move) async => debugPrint('结束移动: $move'),
    );

  }

  setPointCenter()async {

  }
}
