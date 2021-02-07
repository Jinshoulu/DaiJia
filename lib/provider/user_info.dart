
import 'package:demo/public_header.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class UserInfo extends ChangeNotifier{

  /*
    ///省id
  static const String user_province_id = 'user_province_id';
  /// 市 id
  static const String user_city_id = 'user_city_id';
  /// 区 id
  static const String user_area_id = 'user_area_id';
  /// 当前选择位置 省
  static const String user_local_province = 'user_local_province';
  /// 当前选择位置 市
  static const String user_local_city = 'user_local_city';
  /// 当前选择位置 区 县
  static const String user_local_area = 'user_local_area';
  /// 当前选择详细地址
  static const String user_local_address = 'user_local_address';
  /// 当前选择位置 详细地址
  static const String user_local_long = 'user_local_long';
  /// 当前选择位置 详细地址
  static const String user_local_late = 'user_local_late';
  /// 当前选择位置 aoiName
  static const String user_aoi_name = 'user_aoi_name';
   */
  String _user_province_id;
  String _user_city_id;
  String _user_area_id;
  String _user_local_province;
  String _user_local_city;
  String _user_local_area;
  String _user_local_address;
  String _user_local_long;
  String _user_local_late;
  String _user_aoi_name;


  String _phone;//手机号
  String _headimage;//头像
  String _nickname;//昵称
  String _code;//工号
  String _money;//司机余额
  String _imoney;//司机保障金
  String _branch;//代驾分余额
  String _integral;//积分余额
  String _push_status;//是否使用优推
  String _count1;//优推次数余额
  String _count2;//优推时长个数余额
  String _astatus;//审批状态：1未提交2未审批3审批通过4审批未通过
  String _reason;//审批未通过原因
  String _dstatus;//司机状态：1离线2未上线3已上线（空闲）4接单中5服务中
  String _work_time;//驾龄
  String _fileurl1;//驾驶证正本
  String _fileurl2;//驾驶证副本
  String _fileurl3;//身份证正面
  String _fileurl4;//身份证反面
  String _fileurl5;//代驾协议第一页
  String _fileurl6;//代驾协议第二页
  String _fileurl7;//代驾协议第三页
  String _fileurl8;//工装半身照
  String _autograph;//司机签名图片
  String _create_time;//注册时间
  String _star;////星级
  String _tid;////终端ID
  String _trid;////轨迹ID
  String _key;////高德WEBkey
  String _sid;////服务ID

  init(){
    this.phone = SpUtil.getString(AppValue.user_phone,defValue: '');
    this.headimage = SpUtil.getString(AppValue.user_header,defValue: '');
    this.nickname = SpUtil.getString(AppValue.user_nickname,defValue: '');
    this.code = SpUtil.getString(AppValue.user_work_code,defValue: '');
    this.money = SpUtil.getString(AppValue.user_money_balance,defValue: '');
    this.imoney = SpUtil.getString(AppValue.user_imoney_balance,defValue: '');
    this.branch = SpUtil.getString(AppValue.user_branch_balance,defValue: '');
    this.integral = SpUtil.getString(AppValue.user_integral_balance,defValue: '');
    this.push_status = SpUtil.getString(AppValue.user_push_status,defValue: '');
    this.count1 = SpUtil.getString(AppValue.user_push_count,defValue: '');
    this.count2 = SpUtil.getString(AppValue.user_push_count2,defValue: '');
    this.astatus = SpUtil.getString(AppValue.user_application_status,defValue: '');
    this.reason = SpUtil.getString(AppValue.user_refund_reason,defValue: '');
    this.dstatus = SpUtil.getString(AppValue.user_work_status,defValue: '');
    this.work_time = SpUtil.getString(AppValue.user_work_age,defValue: '');
    this.fileurl1 = SpUtil.getString(AppValue.user_image_file1,defValue: '');
    this.fileurl2 = SpUtil.getString(AppValue.user_image_file2,defValue: '');
    this.fileurl3 = SpUtil.getString(AppValue.user_image_file3,defValue: '');
    this.fileurl4 = SpUtil.getString(AppValue.user_image_file4,defValue: '');
    this.fileurl5 = SpUtil.getString(AppValue.user_image_file5,defValue: '');
    this.fileurl6 = SpUtil.getString(AppValue.user_image_file6,defValue: '');
    this.fileurl7 = SpUtil.getString(AppValue.user_image_file7,defValue: '');
    this.fileurl8 = SpUtil.getString(AppValue.user_image_file8,defValue: '');
    this.autograph = SpUtil.getString(AppValue.user_image_sign,defValue: '');
    this.create_time = SpUtil.getString(AppValue.user_create_time,defValue: '');
    this.star = SpUtil.getString(AppValue.user_star,defValue: '');
    this.tid = SpUtil.getString(AppValue.user_tid,defValue: '');
    this.trid = SpUtil.getString(AppValue.user_trid,defValue: '');
    this.sid = SpUtil.getString(AppValue.user_sid,defValue: '');
    this.key = SpUtil.getString(AppValue.user_key,defValue: '');

    //
    this.user_local_late = SpUtil.getString(AppValue.user_local_late,defValue: '34.777334');
    this.user_local_long = SpUtil.getString(AppValue.user_local_long,defValue: '113.707869');
    this.user_local_address = SpUtil.getString(AppValue.user_local_address,defValue: '河南省郑州市金水区中州大道133金成时代广场');
    this.user_local_area = SpUtil.getString(AppValue.user_local_area,defValue: '金水区');
    this.user_local_city = SpUtil.getString(AppValue.user_local_city,defValue: '郑州市');
    this.user_local_province = SpUtil.getString(AppValue.user_local_province,defValue: '河南省');
    this.user_aoi_name = SpUtil.getString(AppValue.user_aoi_name,defValue: '金成时代广场');
    this.user_area_id = SpUtil.getString(AppValue.user_area_id,defValue: '');
    this.user_city_id = SpUtil.getString(AppValue.user_city_id,defValue: '');
    this.user_province_id = SpUtil.getString(AppValue.user_province_id,defValue: '');

  }

  getUserInfo(){

    DioUtils.instance.post(Api.mineInfo,onSucceed: (response){

      if(response is Map){
        var data = response;
        phone = AppClass.data(data, 'phone');
        headimage = AppClass.data(data, 'headimg_all');
        nickname = AppClass.data(data, 'nickname');
        code = AppClass.data(data, 'code');
        money = AppClass.data(data, 'money');
        imoney = AppClass.data(data, 'imoney');
        branch = AppClass.data(data, 'branch');
        integral = AppClass.data(data, 'integral');
        push_status = AppClass.data(data, 'push_status');
        count1 = AppClass.data(data, 'count1');
        count2 = AppClass.data(data, 'count2');
        astatus = AppClass.data(data, 'astatus');
        work_time = AppClass.data(data, 'work_time');
        fileurl1 = AppClass.data(data, 'fileurl1_all');
        fileurl2 = AppClass.data(data, 'fileurl2_all');
        fileurl3 = AppClass.data(data, 'fileurl3_all');
        fileurl4 = AppClass.data(data, 'fileurl4_all');
        fileurl5 = AppClass.data(data, 'fileurl5_all');
        fileurl6 = AppClass.data(data, 'fileurl6_all');
        fileurl7 = AppClass.data(data, 'fileurl7_all');
        fileurl8 = AppClass.data(data, 'fileurl8_all');
        autograph = AppClass.data(data, 'autograph_all');
        create_time = AppClass.data(data, 'create_time');
        star = AppClass.data(data, 'star');
        tid = AppClass.data(data, 'tid');
        trid = AppClass.data(data, 'trid');
        key = AppClass.data(data, 'key');
        sid = AppClass.data(data, 'sid');

        init();
      }

    },onFailure: (code,msg){
        init();
    });

  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
    SpUtil.putString(AppValue.user_phone, value);
    notifyListeners();
  }

  String get headimage => _headimage;

  set headimage(String value){
    _headimage = value;
    SpUtil.putString(AppValue.user_header, value);
    notifyListeners();
  }

  String get nickname => _nickname;

  set nickname(String value) {
    _nickname = value;
    SpUtil.putString(AppValue.user_nickname, value);
    notifyListeners();
  }


  String get code => _code;

  set code(String value) {
    _code = value;
    SpUtil.putString(AppValue.user_work_code, value);
    notifyListeners();
  }

  String get money => _money;

  set money(String value) {
    _money = value;
    SpUtil.putString(AppValue.user_money_balance, value);
    notifyListeners();
  }

  String get imoney => _imoney;

  set imoney(String value) {
    _imoney = value;
    SpUtil.putString(AppValue.user_imoney_balance, value);
    notifyListeners();
  }

  String get branch => _branch;

  set branch(String value) {
    _branch = value;
    SpUtil.putString(AppValue.user_branch_balance, value);
    notifyListeners();
  }

  String get integral => _integral;

  set integral(String value) {
    _integral = value;
    SpUtil.putString(AppValue.user_integral_balance, value);
    notifyListeners();
  }

  String get push_status => _push_status;

  set push_status(String value) {
    _push_status = value;
    SpUtil.putString(AppValue.user_push_status, value);
    notifyListeners();
  }

  String get count1 => _count1;

  set count1(String value) {
    _count1 = value;
    SpUtil.putString(AppValue.user_push_count, value);
    notifyListeners();
  }

  String get count2 => _count2;

  set count2(String value) {
    _count2 = value;
    SpUtil.putString(AppValue.user_push_count2, value);
    notifyListeners();
  }

  String get astatus => _astatus;

  set astatus(String value) {
    _astatus = value;
    SpUtil.putString(AppValue.user_application_status, value);
    notifyListeners();
  }

  String get reason => _reason;

  set reason(String value) {
    _reason = value;
    SpUtil.putString(AppValue.user_refund_reason, value);
    notifyListeners();
  }

  String get dstatus => _dstatus;

  set dstatus(String value) {
    _dstatus = value;
    SpUtil.putString(AppValue.user_work_status, value);
    notifyListeners();
  }

  String get work_time => _work_time;

  set work_time(String value) {
    _work_time = value;
    SpUtil.putString(AppValue.user_work_age, value);
    notifyListeners();
  }

  String get fileurl1 => _fileurl1;

  set fileurl1(String value) {
    _fileurl1 = value;
    SpUtil.putString(AppValue.user_image_file1, value);
    notifyListeners();
  }

  String get fileurl2 => _fileurl2;

  set fileurl2(String value) {
    _fileurl2 = value;
    SpUtil.putString(AppValue.user_image_file2, value);
    notifyListeners();
  }

  String get fileurl3 => _fileurl3;

  set fileurl3(String value) {
    _fileurl3 = value;
    SpUtil.putString(AppValue.user_image_file3, value);
    notifyListeners();
  }

  String get fileurl4 => _fileurl4;

  set fileurl4(String value) {
    _fileurl4 = value;
    SpUtil.putString(AppValue.user_image_file4, value);
    notifyListeners();
  }

  String get fileurl5 => _fileurl5;

  set fileurl5(String value) {
    _fileurl5 = value;
    SpUtil.putString(AppValue.user_image_file5, value);
    notifyListeners();
  }

  String get fileurl6 => _fileurl6;

  set fileurl6(String value) {
    _fileurl6 = value;
    SpUtil.putString(AppValue.user_image_file6, value);
    notifyListeners();
  }

  String get fileurl7 => _fileurl7;

  set fileurl7(String value) {
    _fileurl7 = value;
    SpUtil.putString(AppValue.user_image_file7, value);
    notifyListeners();
  }

  String get fileurl8 => _fileurl8;

  set fileurl8(String value) {
    _fileurl8 = value;
    SpUtil.putString(AppValue.user_image_file8, value);
    notifyListeners();
  }

  String get autograph => _autograph;

  set autograph(String value) {
    _autograph = value;
    SpUtil.putString(AppValue.user_image_sign, value);
    notifyListeners();
  }

  String get create_time => _create_time;

  set create_time(String value) {
    _create_time = value;
    SpUtil.putString(AppValue.user_create_time, value);
    notifyListeners();
  }

  String get star => _star;

  set star(String value) {
    _star = value;
    SpUtil.putString(AppValue.user_star, value);
    notifyListeners();
  }



  String get tid => _tid;

  set tid(String value) {
    _tid = value;
    SpUtil.putString(AppValue.user_tid, value);
    notifyListeners();
  }

  String get trid => _trid;

  set trid(String value) {
    _trid = value;
    SpUtil.putString(AppValue.user_trid, value);
    notifyListeners();
  }

  String get key => _key;

  set key(String value) {
    _key = value;
    SpUtil.putString(AppValue.user_key, value);
    notifyListeners();
  }

  String get sid => _sid;

  set sid(String value) {
    _sid = value;
    SpUtil.putString(AppValue.user_sid, value);
    notifyListeners();
  }


  //位置

  String get user_province_id => _user_province_id;

  set user_province_id(String value) {
    _user_province_id = value;
    SpUtil.putString(AppValue.user_province_id, value);
    notifyListeners();
  }


  String get user_city_id => _user_city_id;

  set user_city_id(String value) {
    _user_city_id = value;
    SpUtil.putString(AppValue.user_city_id, value);
    notifyListeners();
  }

  String get user_area_id => _user_area_id;

  set user_area_id(String value) {
    _user_area_id = value;
    SpUtil.putString(AppValue.user_area_id, value);
    notifyListeners();
  }

  String get user_local_province => _user_local_province;

  set user_local_province(String value) {
    _user_local_province = value;
    SpUtil.putString(AppValue.user_local_province, value);
    notifyListeners();
  }

  String get user_local_city => _user_local_city;

  set user_local_city(String value) {
    _user_local_city = value;
    SpUtil.putString(AppValue.user_local_city, value);
    notifyListeners();
  }

  String get user_local_area => _user_local_area;

  set user_local_area(String value) {
    _user_local_area = value;
    SpUtil.putString(AppValue.user_local_area, value);
    notifyListeners();
  }

  String get user_local_address => _user_local_address;

  set user_local_address(String value) {
    _user_local_address = value;
    SpUtil.putString(AppValue.user_local_address, value);
    notifyListeners();
  }

  String get user_local_long => _user_local_long;

  set user_local_long(String value) {
    _user_local_long = value;
    SpUtil.putString(AppValue.user_local_long, value);
    notifyListeners();
  }

  String get user_local_late => _user_local_late;

  set user_local_late(String value) {
    _user_local_late = value;
    SpUtil.putString(AppValue.user_local_late, value);
    notifyListeners();
  }

  String get user_aoi_name => _user_aoi_name;

  set user_aoi_name(String value) {
    _user_aoi_name = value;
    SpUtil.putString(AppValue.user_aoi_name, value);
    notifyListeners();
  }
}