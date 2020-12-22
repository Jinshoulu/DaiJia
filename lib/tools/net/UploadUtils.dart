import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:demo/tools/res/DateUtils.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:oktoast/oktoast.dart';

import '../../public_header.dart';
import 'md5.dart';


class UploadUtils {
  static const String qiniu_upload = "http://upload.qiniup.com/";

  static Future<String> uploadVideo2(
    String path, {
    Function succeed,
    Function failure,
    Function sendProgress,
  }) async {
    if (path == null || path.isEmpty) {
      if (failure != null) {
        failure();
      }
      return "";
    }
    try {
      String fileName =
          DateUtils.getNowDateMs().toString() + "_" + (path.split("/").last);
      String fileSuffix = fileName.split(".").last;

      Dio dio = new Dio(BaseOptions(responseType: ResponseType.json));
      Response response = await dio.post(Api.qiniutoken,
          options: Options(
              headers: {"token": SpUtil.getString(AppValue.token)}));
      if (response?.data['code'] == 1) {
        //{
        //         "token": "MjLdiE3XKIMStnzRxEXi1gfIpbb77ssp6cpRbFKU:4S_jCjn71O_BiZeGnU6dLHnPnoc=:eyJyZXR1cm5Cb2R5Ijoie1wia2V5XCI6ICQoa2V5KSxcInNpemVcIjogJChmc2l6ZSksXCJ3XCI6ICQoaW1hZ2VJbmZvLndpZHRoKSxcImhcIjogJChpbWFnZUluZm8uaGVpZ2h0KSxcImhhc2hcIjogJChldGFnKX0iLCJzY29wZSI6InN1YmFuZyIsImRlYWRsaW5lIjoxNjAzMzYxNTQ0fQ==",
        //         "domain": "http://imgs.sbyssh.com/"
        //     }
        String token = response?.data['data']['token'];
        MultipartFile multipartFile = await MultipartFile.fromFile(path,
            filename: generateMd5(fileName) + ".$fileSuffix");
        var formData = FormData.fromMap({
          "file": multipartFile,
          "token": token,
          "key": generateMd5(fileName) + ".$fileSuffix",
        });

        Response responseUpload = await dio.post(
          qiniu_upload,
          data: formData,
          onSendProgress: (int sent, int total) {
            print("上传进度" + "$sent $total"); //send是上传的大小 total是总文件大小
            if (sendProgress != null) {
              sendProgress(sent, total);
            }
          },
        );
        print("上传结果：" + responseUpload?.data?.toString());
        //{key: image_picker2722720889574759878.jpg, size: 486943, w: 1440, h: 1920, hash: FvK7cWnC5vgtMclzS0oGrDb-nQSt}
        if (succeed != null) {
          succeed(response?.data['data']['domain'] + responseUpload?.data['key']);
        }
        return response?.data['data']['domain'] + responseUpload.data['key'];
      } else {
        showToast("上传失败");
        if (failure != null) {
          failure();
        }
        return "";
      }
    } catch (e) {
      showToast("上传失败");
      if (failure != null) {
        failure();
      }
      return "";
    }
  }

  static Future<String> uploadImage2(
    String path, {
    Function succeed,
    Function failure,
    Function sendProgress,
  }) async {
    try {
      File compressedFile = await FlutterNativeImage.compressImage(path,
          quality: 30, percentage: 50);

      Dio dio = new Dio(BaseOptions(
          responseType: ResponseType.json,
          connectTimeout: 1 * 60 * 1000,
          receiveTimeout: 10 * 60 * 1000));
      Response response = await dio.post(Api.qiniutoken,
          options: Options(
              headers: {"token": SpUtil.getString(AppValue.token)}));
      debugPrint("获取七牛token：" + response.data.toString());
      if (response?.data['code'] == 1) {
        String re = json.encode(response?.data);
        print("七牛token：" + response?.data?.toString());
        String token = response?.data['data']['token'];
        String fileName =
            DateUtils.getNowDateMs().toString() + "_" + (path.split("/").last);
        Uint8List fileInt = await compressedFile.readAsBytes();
        MultipartFile multipartFile =
            MultipartFile.fromBytes(fileInt, filename: fileName);
        var formData = FormData.fromMap({
          "file": multipartFile,
          "token": token,
          "key": fileName,
        });
        Response responseUpload = await dio.post(
          qiniu_upload,
          data: formData,
          onSendProgress: (int sent, int total) {
            print("上传进度" + "$sent $total"); //send是上传的大小 total是总文件大小
            if (sendProgress != null) {
              sendProgress(sent, total);
            }
          },
        );
        print("上传结果：" + responseUpload?.data?.toString());
        //{key: image_picker2722720889574759878.jpg, size: 486943, w: 1440, h: 1920, hash: FvK7cWnC5vgtMclzS0oGrDb-nQSt}
        if (succeed != null) {
          succeed(response?.data['data']['domain'] + responseUpload?.data['key'],responseUpload?.data['w'],responseUpload?.data['h']);
        }
        return response?.data['data']['domain'] + responseUpload.data['key'];
      } else {
        showToast("上传失败");

        if (failure != null) {
          failure();
        }
        return "";
      }
    } catch (e) {
      print("上传失败");
      print(e);
      if (e is DioError) {
        if ("Http status error [614]" == e.error) {
          debugPrint("1111${e.error}");
        }
      }
      showToast("上传失败");
      if (failure != null) {
        failure();
      }
      return "";
    }
  }
}
