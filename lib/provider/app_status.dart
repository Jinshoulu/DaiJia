

import 'package:demo/public_header.dart';
import 'package:demo/z_tools/save_data.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';

class AppStatus with ChangeNotifier{

  ///网络状态
  bool _connect;
  bool get connect => _connect;

  set connect(bool value) {
    _connect = value;
    SpUtil.putBool(SaveData.connectStatus, value);
    notifyListeners();
  }

  init(){
    this.connect = SpUtil.getBool(SaveData.connectStatus,defValue: true);
    this.orderStatus = 0;
    this.address = SpUtil.getString(AppValue.user_local_address,defValue: '');
    this.lon = SpUtil.getString(AppValue.user_local_long,defValue: '');
    this.late = SpUtil.getString(AppValue.user_local_late,defValue: '');
    this.aoiName = SpUtil.getString(AppValue.user_aoi_name,defValue: '');
    this.cityCode = SpUtil.getString(AppValue.user_select_city_code,defValue: '');
    this.city = SpUtil.getString(AppValue.user_select_city,defValue: '');
  }

  ///接单状态
  int _orderStatus;
  int get orderStatus => _orderStatus;

  set orderStatus(int value) {
    _orderStatus = value;
    SpUtil.putInt(SaveData.receivedOrderStatus, value);
    notifyListeners();
  }

  //地理位置
  String _address;
  String _aoiName;
  String _lon;
  String _late;
  String _city;
  String _province;
  String _cityCode;

  String get address => _address;

  set address(String value) {
    _address = value;
    SpUtil.putString(AppValue.user_local_address, value);
    notifyListeners();
  }

  String get aoiName => _aoiName;

  set aoiName(String value) {
    _aoiName = value;
    SpUtil.putString(AppValue.user_aoi_name, value);
    notifyListeners();
  }

  String get lon => _lon;

  set lon(String value) {
    _lon = value;
    SpUtil.putString(AppValue.user_local_long, value);
    notifyListeners();
  }

  String get late => _late;

  set late(String value) {
    _late = value;
    SpUtil.putString(AppValue.user_local_late, value);
    notifyListeners();
  }

  String get city => _city;

  set city(String value) {
    _city = value;
    SpUtil.putString(AppValue.user_local_address, value);
    notifyListeners();
  }

  String get province => _province;

  set province(String value) {
    _province = value;
    SpUtil.putString(AppValue.user_local_province, value);
    notifyListeners();
  }

  String get cityCode => _cityCode;

  set cityCode(String value) {
    _cityCode = value;
    SpUtil.putString(AppValue.user_select_city_code, value);
    notifyListeners();
  }
}