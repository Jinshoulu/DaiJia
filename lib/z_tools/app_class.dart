
import 'dart:typed_data';

import 'package:demo/z_tools/save_data.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_getuuid/flutter_getuuid.dart';
import 'package:flutter_phoneinfo/flutter_phoneinfo.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../public_header.dart';

class AppClass {

  static exitApp(BuildContext context){
    SpUtil.remove(AppValue.token);
    SpUtil.remove(AppValue.token_expiration);
    SpUtil.remove(AppValue.user_phone);
    SpUtil.remove(AppValue.refresh_token);
    SpUtil.remove(AppValue.login_state);
    AppPush.push(context, LoginRouter.loginPage,clearStack: true);
  }

  ///保存图片到本地
  static Future saveImageToLocalPhotos(String image)async{
    var response = await Dio().get(
        image,
        options: Options(responseType: ResponseType.bytes),onReceiveProgress: (value, value2){
      print(value);
      print(value2);
    });
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: DateTime.now().toString());
    print('保存到本地相册 = result = $result');
    return result;
  }

  //将秒转换成时分秒
  static secondChangeTime(int second){

    int hourTime = second~/3600;
    int minTime = second~/60%60;
    int secTime = second%60;
    String hour = hourTime<10?'0$hourTime':hourTime.toString();
    String min = minTime<10?'0$minTime':minTime.toString();
    String sec = secTime<10?'0$secTime':secTime.toString();

    if(hourTime==0){
      return min+':'+sec;
    }
    return hour+':'+min+':'+sec;

  }

  static Future<String> netFetch() async {
    /// 获取手机的UUID
    var uuid = await FlutterGetuuid.platformUid;
    /// 获取手机的型号如“iPhone7”
    var phoneMark = await FlutterGetuuid.platformDeviceModle;
    /// 获取项目的vesion-code
    var version = await FlutterGetuuid.platformVersionCode;
    /// 获取系统SDK版本
    var systemMark = await FlutterGetuuid.platformSystemMark;

    SpUtil.putString(AppValue.user_only_one_id, uuid);
    debugPrint('FlutterGetuuid sdk uuid = $uuid, phoneMark = $phoneMark version = $version systemMark = $systemMark');
    return uuid;
  }

  static Future<String> initPlatformState() async {
    String platformVersion;
    String uuid;
    String mac;
    String identifier;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterPhoneinfo.platformVersion;
      mac = await FlutterPhoneinfo.getMac;
      uuid=await FlutterPhoneinfo.getUUID;
      identifier=await  FlutterPhoneinfo.getIdentifier;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    SpUtil.putString(AppValue.user_only_one_id, uuid);
    debugPrint('FlutterPhoneinfo sdk identifier = $identifier uuid = $uuid mac = $mac version = $platformVersion');
    return uuid;
  }

  /// getAccessToken
  static getAccessToken(String code, BuildContext context) async {

    print('weixin code = $code}');
    String APPID = "wx30a1a2ffb5fdc3c3";
    String SECRET = "f59e76ff3041d3c5ede8b85c55919d1e";
    String wx_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=$APPID&secret=$SECRET&code=$code&grant_type=authorization_code";
    Response response = await Dio().get(wx_url);
    var json = jsonDecode(response?.data??"{}");
    print('map1 = $json');
    if(json['access_token']!=null &&  json["openid"]!=null){
      String token = json["access_token"];
      String openid = json["openid"];
      getUserInfo(token, openid, context);
    }else{
      Toast.show("获取微信AccessToken失败！");
    }

  }

  /// 获取用户详细信息
  static getUserInfo(String token, String openid, BuildContext context) {
    Dio dio = new Dio();
    dio.get("https://api.weixin.qq.com/sns/userinfo?", queryParameters: {
      "access_token": token,
      "openid": openid,
      "lang": "zh_CN"
    }).then((response) {
      changeWechatParameters(response?.data, context);
    });
  }

  static changeWechatParameters(var user, BuildContext context) {
    if(user == null)return;
    ///1.是QQ 2.微信
    var params;
    String openId;
    if (Platform.isIOS) {
      WechatInfoIOS wechatInfoIOS = WechatInfoIOS.fromJson(jsonDecode(user.toString()));
      if(wechatInfoIOS!=null){
        openId = wechatInfoIOS.openid??'';
      }
    } else {
      WxAndroidInfo weixinInfo = WxAndroidInfo.fromJson(jsonDecode(user.toString()));
      if(weixinInfo!=null){
        openId = weixinInfo?.openid??'';
      }
    }
  }

  static data(data,String key){
    if(data==null){
      return '';
    }
    if(data[key]==null){
      return '';
    }
    String value = data[key].toString();
    return value=='null'?'':value;
  }

  static saveCurrentAddressData(var data){

    var addressData = SpUtil.getObject(SaveData.unSubmitAddressData);
    if(addressData!=null){
      if(addressData['data']!=null){
        if(addressData['data'] is List){
          List list = addressData['data'];
          list.add(data);
          SpUtil.putObject(SaveData.unSubmitAddressData, {'data':list});
        }
      }
    }
  }

  static Future<List> getUploadSaveAddress()async{
    var addressData = SpUtil.getObject(SaveData.unSubmitAddressData);
    if(addressData!=null){
      if(addressData['data']!=null){
        if(addressData['data'] is List){
          return addressData['data'];
        }
      }
    }
    return [];
  }

  ///保存值
  static saveData(var value,String key){
    String loginAccount = SpUtil.getString(AppValue.login_account);
    if(value!=null){
      SpUtil.putObject(loginAccount+key, {'data':value}).then((value){
        if(value){
          debugPrint('保存成功');
        }else{
          debugPrint('保存失败');
        }
      });
    }else{
      debugPrint('保存的数据为null,不做处理');
    }
  }
  ///读取保存的值
  static Future<dynamic> readData(String key)async{
    String loginAccount = SpUtil.getString(AppValue.login_account);
    var addressData = SpUtil.getObject(loginAccount+key);
    if(addressData!=null){
      if(addressData['data']!=null){
        return addressData['data'];
      }else{
        debugPrint('读取的数据为null,不做处理');
        return null;
      }
    }else{
      debugPrint('读取的数据为null,不做处理');
      return null;
    }
  }

}


class WechatInfoIOS {
  String city;
  String country;
  String headimgurl;
  String language;
  String nickname;
  String openid;

//    List<Object> privilege;
  String province;
  int sex;
  String unionid;

  WechatInfoIOS(
      {this.city,
        this.country,
        this.headimgurl,
        this.language,
        this.nickname,
        this.openid,
        this.province,
        this.sex,
        this.unionid});

  factory WechatInfoIOS.fromJson(Map<String, dynamic> json) {
    return WechatInfoIOS(
      city: json['city'],
      country: json['country'],
      headimgurl: json['headimgurl'],
      language: json['language'],
      nickname: json['nickname'],
      openid: json['openid'],
//            privilege: json['privilege'] != null ? (json['privilege'] as List).map((i) => Object.fromJson(i)).toList() : null,
      province: json['province'],
      sex: json['sex'],
      unionid: json['unionid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    data['headimgurl'] = this.headimgurl;
    data['language'] = this.language;
    data['nickname'] = this.nickname;
    data['openid'] = this.openid;
    data['province'] = this.province;
    data['sex'] = this.sex;
    data['unionid'] = this.unionid;
//        if (this.privilege != null) {
//            data['privilege'] = this.privilege.map((v) => v.toJson()).toList();
//        }
    return data;
  }
}

class WxAndroidInfo {
  String city;
  String country;
  String headimgurl;
  String language;
  String nickname;
  String openid;
  String province;
  int sex;
  String unionid;

  WxAndroidInfo({this.city, this.country, this.headimgurl, this.language, this.nickname, this.openid, this.province, this.sex, this.unionid});

  factory WxAndroidInfo.fromJson(Map<String, dynamic> json) {
    return WxAndroidInfo(
      city: json['city'],
      country: json['country'],
      headimgurl: json['headimgurl'],
      language: json['language'],
      nickname: json['nickname'],
      openid: json['openid'],
      province: json['province'],
      sex: json['sex'],
      unionid: json['unionid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    data['headimgurl'] = this.headimgurl;
    data['language'] = this.language;
    data['nickname'] = this.nickname;
    data['openid'] = this.openid;
    data['province'] = this.province;
    data['sex'] = this.sex;
    data['unionid'] = this.unionid;
    return data;
  }
}

