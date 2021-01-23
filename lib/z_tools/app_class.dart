
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
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

}