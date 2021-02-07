
import 'dart:convert';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:demo/provider/user_info.dart';
import 'package:demo/z_tools/save_data.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../public_header.dart';

class AppLocal {

  static Future reloadLocation (BuildContext context)async{

    Permission.location.request().then((value)async{
      if(value.isGranted){
        final result = await AmapLocation.instance.fetchLocation(mode: LocationAccuracy.High);
        if(result.latLng.longitude==null){
          Toast.show('定位尚未开启，只能展示默认位置');
          return '';
        }else{
          Provider.of<UserInfo>(context,listen: false).user_local_late = result.latLng.latitude.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_long = result.latLng.longitude.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_province = result.province.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_city = result.city.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_area = result.district.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_address = result.address.toString();
          Provider.of<UserInfo>(context,listen: false).user_aoi_name = result.aoiName==null?result.street.toString():result.aoiName.toString();
          return '';
        }

      }else{
        Toast.show('定位权限尚未开启，只能展示默认位置');
        return '';
      }
    });
  }
  static Future getLocation (BuildContext context) async {

    Permission.location.request().then((value)async{
      if(value.isGranted){
        final result = await AmapLocation.instance.fetchLocation(
          mode: LocationAccuracy.High
        );
        debugPrint('获取当前的位置信息 = ${result}');
        if(result.latLng.longitude==null){
          Toast.show('定位尚未开启，只能展示默认位置');
          return '';
        }else{
          Provider.of<UserInfo>(context,listen: false).user_local_late = result.latLng.latitude.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_long = result.latLng.longitude.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_province = result.province.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_city = result.city.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_area = result.district.toString();
          Provider.of<UserInfo>(context,listen: false).user_local_address = result.address.toString();
          Provider.of<UserInfo>(context,listen: false).user_aoi_name = result.aoiName==null?result.street.toString():result.aoiName.toString();

          return getCityCode(result.province.toString(),result.city.toString(),result.district.toString(),context);
        }

      }else{
        Toast.show('定位权限尚未开启，只能展示默认位置');
        return '';
      }
    });

  }

  static getCityCode(String province,String cityName,String area,BuildContext context){
    if(cityName?.isEmpty??true){
      return '';
    }
    if(SpUtil.getObject(SaveData.cityList)!=null){
      var data = SpUtil.getObject(SaveData.cityList);
      if(data is Map){
        if(data['list']!=null){
          debugPrint('保存的数据 -------> $data');
          getAreaId(data['list'],province,cityName,area,context);
        }else{
          sendRequest(province, cityName, area,context);
        }
      }else{
        sendRequest(province, cityName, area,context);
      }
    }else{
      sendRequest(province, cityName, area,context);
    }

  }

  static sendRequest(String province,String cityName,String area,BuildContext context){
    DioUtils.instance.post(Api.getCityListUrl,onFailure: (code,msg){

    },onSucceed: (response){
      if(response is List){
        if(response.isNotEmpty){
          SpUtil.putObject(SaveData.cityList, {'list':response});
          getAreaId(response,province,cityName,area,context);
        }
      }
    });
  }

  ///获取区 id
  static getAreaId(data,String province,String cityName,String area,BuildContext context){

    if(data != null && data is List){
      ///读取数组
      for(int i = 0;i<data.length; i++){
        ///获取省级
        var subDic = data[i];
        String label = subDic['label'];
        print('label = $label, province = $province');
        ///寻找匹配项
        if(label.contains(province)){
          debugPrint('捕捉到 省级匹配项---->11111111');
          String provinceId = subDic['value'].toString();
          Provider.of<UserInfo>(context,listen: false).user_province_id = provinceId;
          ///读取市级数组
          List cityList = subDic['children'];
          for(int i = 0;i<cityList.length; i++){
            ///获取省级
            var cityDic = cityList[i];
            String label2 = cityDic['label'];
            ///寻找匹配项
            if(label2.contains(cityName)){
              debugPrint('捕捉到 市级匹配项 ----> 222222');
              String cityId = cityDic['value'].toString();
              Provider.of<UserInfo>(context,listen: false).user_city_id = cityId;
              ///读取县级数组
              List areaList = cityDic['children'];
              bool isHave = false;
              for(int i = 0;i<areaList.length; i++){
                ///获取省级
                var areaDic = areaList[i];
                String label3 = areaDic['label'];
                ///寻找匹配项
                if(label3.contains(area)){
                  isHave = true;
                  debugPrint('捕捉到 县级匹配项 ----> 3333333');
                  String areaId = areaDic['value'].toString();
                  Provider.of<UserInfo>(context,listen: false).user_area_id = areaId;
                  return;
                }
              }
              if(isHave==false){
                if(areaList.length>0){
                  debugPrint('未找到匹配项 获取数组第一条数据 ----> 6666666666');
                  var areaDic = areaList.first;
                  String areaId = areaDic['value'].toString();
                  Provider.of<UserInfo>(context,listen: false).user_area_id = areaId;
                  debugPrint('--------->$provinceId ---->$cityId --->$areaId');
                  return;
                }else{
                  debugPrint('县级数组是空的 获取市级 id充当数据 ----> 6666666666');
                  String areaId = cityDic['value'].toString();
                  Provider.of<UserInfo>(context,listen: false).user_area_id = areaId;
                  debugPrint('--------->$provinceId ---->$cityId --->$areaId');
                  return;
                }
              }
            }
          }
        }
      }
    }

  }

}