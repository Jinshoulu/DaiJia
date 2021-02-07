
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class MapClass {

  ///获取两点之间的路径 骑行 地图框架、开始位置、结束位置
  static getRoutePath(AmapController controller, LatLng startPoint, LatLng endPoint,Function result)async{
    final routeResult = await AmapSearch.instance.searchRideRoute(
      from: startPoint,
      to: endPoint,
    );
    List<RidePath> list = await routeResult.ridePathList;

    list.forEach((element){
      element.rideStepList.then((value)async{
        double distance = 0.0;
        double time = 0.0;
        print('element count = ${value.length}');
        List<RideStep> paths = value;
        for(int i = 0;i<paths.length;i++){
          RideStep element = paths[i];
          await element.distance.then((value){
            distance = distance+value;
          });
          await element.duration.then((value){
            time = time+value;
          });
          await element.polyline.then((value){
            controller?.addPolyline(PolylineOption(
              coordinateList: value,
              width: 10,
              strokeColor: AppColors.mainColor,
            ));
          });
          if(paths.length-1==i){
            time = time/60;
            distance = distance/1000.0;
            result({'distance':distance.toStringAsFixed(1),'time':time.toStringAsFixed(0)});
          }
        }
      });
    });
  }

  ///获取两点之间的路径 驾车 地图框架、开始位置、结束位置
  static getDriverPath(AmapController controller, LatLng startPoint, LatLng endPoint,Function result)async{
    final routeResult = await AmapSearch.instance.searchDriveRoute(
      from: startPoint,
      to: endPoint,
    );
    List<DrivePath> list = await routeResult.drivePathList;

    list.forEach((element){
      element.driveStepList.then((value)async{
        double distance = 0.0;
        double time = 0.0;
        print('element count = ${value.length}');
        List<DriveStep> paths = value;
        for(int i = 0;i<paths.length;i++){
          DriveStep element = paths[i];
          await element.distance.then((value){
            distance = distance+value;
          });
          await element.duration.then((value){
            time = time+value;
          });
          await element.polyline.then((value){
            controller?.addPolyline(PolylineOption(
              coordinateList: value,
              width: 10,
              strokeColor: AppColors.mainColor,
            ));
          });
          if(paths.length-1==i){
            time = time/60;
            distance = distance/1000.0;
            result({'distance':distance.toStringAsFixed(1),'time':time});
          }
        }
      });
    });
  }

  ///获取两点之间的直线距离
  static getTwoPointsDistance(LatLng point1,LatLng point2)async{
    var result = await AmapService.instance.calculateDistance(point1, point2);
    result = result/1000.0;
    return result.toStringAsFixed(1);
  }

  ///添加标签 mark
  static addMarkerOption(AmapController controller,LatLng point)async{
    await controller?.addMarker(MarkerOption(
        coordinate: point,
        visible: true,
        iconProvider: AssetImage('assets/images/司机-忙碌.png'),
        widget: Container(
          width: 100,
          height: 100,
          color: Colors.white,
          child: Stack(
            children: <Widget>[],
          ),
        ))
    );
  }
}