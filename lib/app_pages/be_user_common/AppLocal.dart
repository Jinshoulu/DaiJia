
import 'dart:convert';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../public_header.dart';

class AppLocal {

  static Future getLocation () async {
    Permission.location.request().then((value)async{
      if(value.isGranted){
        final result = await AmapLocation.instance.fetchLocation(
          mode: LocationAccuracy.High
        );
        debugPrint('获取当前的位置信息 = ${result}');
        if(result.latLng.longitude==null){
          Toast.show('定位尚未开启，只能展示默认位置');
          if(SpUtil.getString(AppValue.user_select_city)==null){
            return '400100';
          }
          return SpUtil.getString(AppValue.user_select_city_code);
        }else{
          SpUtil.putString(AppValue.user_local_late, result.latLng.latitude.toString());
          SpUtil.putString(AppValue.user_local_long, result.latLng.longitude.toString());
          SpUtil.putString(AppValue.user_local_province, result.province.toString());
          SpUtil.putString(AppValue.user_local_city, result.city.toString());
          SpUtil.putString(AppValue.user_select_city, result.city.toString());
          SpUtil.putString(AppValue.user_local_address, result.address.toString());
          SpUtil.putString(AppValue.user_select_city_code, result.cityCode.toString());
          SpUtil.putString(AppValue.user_aoi_name, result.aoiName.toString());
          return result.cityCode;
        }

      }else{
        Toast.show('定位权限尚未开启，只能展示默认位置');
        SpUtil.putString(AppValue.user_local_late, '34.777334');
        SpUtil.putString(AppValue.user_local_long, '113.707869');
        SpUtil.putString(AppValue.user_local_province, '河南省');
        SpUtil.putString(AppValue.user_local_city, '郑州');
        SpUtil.putString(AppValue.user_select_city, '郑州');
        SpUtil.putString(AppValue.user_local_address, '河南省郑州市金水区中州大道133金成时代广场');
        SpUtil.putString(AppValue.user_select_city_code, '400100');
        SpUtil.putString(AppValue.user_aoi_name, '金成时代广场');
        return '';
      }
    });

  }

  static getCityCode(String cityName){
    if(cityName?.isEmpty??true){
      return '400100';
    }

    String pinyin = PinyinHelper.getPinyin(cityName,separator: "",format: PinyinFormat.WITHOUT_TONE);
    String heightStr = pinyin.toUpperCase();
    if(heightStr.length>1){
      heightStr = heightStr.substring(0,1);
    }
    if(heightStr.isNotEmpty){
      rootBundle.loadString('assets/data/city.json').then((value) {
        Map dataMap = json.decode(value);
        List subList = dataMap[heightStr];
        subList.forEach((element) {
          var data = element;
          String pinyinStr = data['fullfight'];
          if(pinyin==pinyinStr){
            debugPrint(data.toString());
            SpUtil.putString(AppValue.user_select_city, data['name'].toString());
            SpUtil.putString(AppValue.user_local_city, data['name'].toString());
            SpUtil.putString(AppValue.user_select_city_code, data['code'].toString());
            return data['code'];
          }
        });
      });
    }else{
      return '400100';
    }
  }

}