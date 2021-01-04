
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

}