

import 'dart:io';

import 'package:demo/z_tools/dialog/default_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../public_header.dart';




class AppSubmitImage {

  static showDialog(BuildContext context,Function(ImageBean) imageFile){

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DefaultBottomSheet(
            onPress1: (){
              Permission.camera.request().then((value)async{
                if(value.isGranted){
                  var image = await ImagePicker.pickImage(source: ImageSource.camera);
                  File file = await FlutterNativeImage.compressImage(image.path, quality: 30, percentage: 50);
                  uploadFile(file).then((value){
                    if(value=='失败'){
                      Toast.show('图片提交失败,请重试');
                      return;
                    }
                    ImageBean imageBean = ImageBean.fromJson(jsonDecode(value));
                    imageFile(imageBean);
                  });
                }else{
                  Toast.show('检测到您拒绝访问相机权限,请到应用设置页面打开权限');
                }
              });

            },
            onPress2: (){
              Permission.photos.request().then((value)async{
                if(value.isGranted){
                  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  File file = await FlutterNativeImage.compressImage(image.path, quality: 30, percentage: 50);
                  uploadFile(file).then((value){
                    if(value=='失败'){
                      Toast.show('图片提交失败,请重试');
                      return;
                    }
                    ImageBean imageBean = ImageBean.fromJson(jsonDecode(value));
                    imageFile(imageBean);
                  });

                }else{
                  Toast.show('检测到您拒绝访问相册权限,请到应用设置页面打开权限');
                }
              });
            }
        );
      },
    );
  }

  static Future uploadFile (File file) async {

    try {
      Response response;
      Map<String, dynamic> headers = new Map();

      String cookie = SpUtil.getString("cookie");
      if (cookie == null || cookie.length == 0) {
      } else {
        headers['Cookie'] = cookie;
      }
      Options options = Options(contentType: 'multipart/form-data');

      String path = file.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(path, filename:name)
      });

      Dio dio = new Dio();
      if (file == null) {
        response = await dio.post<String>(Api.uploadUrl);
      } else {
        response = await dio.post<String>(Api.uploadUrl, data: formData, options: options, onSendProgress: (int progress, int total) {
          print("当前进度是 $progress 总进度是 $total");
        });
      }
      print("POST:URL=" + Api.uploadUrl);
      print("POST:StatusCode=" + response.statusCode.toString());
      print("POST:BODY=" + formData.toString());
      print("POST:RESULT=" + response.data.toString());
      print("POST:header=" + response.headers.toString());
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return "失败";
      }
    } catch (e) {
      print("失败" + "\nPOST:URL=" + Api.baseApi+Api.uploadUrl);
      print("失败" + "\nPOST:BODY=" + file.toString());
      print("失败" + "\nPOST:ERROR=" + e.toString());
      return "失败";
    }

  }

}




class ImageBean {
  Data data;
  int code;
  String msg;

  ImageBean({this.data, this.code, this.msg});

  factory ImageBean.fromJson(Map<String, dynamic> json) {
    return ImageBean(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      code: json['code'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
    String fileext;
    String filename;
    int filesize;
    String fileurl;
    String fileurls;
    String mime;
    String name;

    Data({this.fileext, this.filename, this.filesize, this.fileurl, this.fileurls, this.mime, this.name});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            fileext: json['fileext'], 
            filename: json['filename'], 
            filesize: json['filesize'], 
            fileurl: json['fileurl'], 
            fileurls: json['fileurls'], 
            mime: json['mime'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['fileext'] = this.fileext;
        data['filename'] = this.filename;
        data['filesize'] = this.filesize;
        data['fileurl'] = this.fileurl;
        data['fileurls'] = this.fileurls;
        data['mime'] = this.mime;
        data['name'] = this.name;
        return data;
    }
}