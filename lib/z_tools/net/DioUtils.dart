import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import '../../public_header.dart';
import '../app_bus_event.dart';
import 'LoadingView.dart';
import 'LoggingInterceptor.dart';
import 'TokenInterceptor.dart';

//// 必须是顶层函数
//_parseAndDecode(String response) {
//  return json.decode(response);
//}
//
//parseJson(String text) {
//  return compute(_parseAndDecode, text);
//}
class DioUtils {
  static final DioUtils instance = DioUtils._internal();

  factory DioUtils() => instance;
  Dio dio;

  DioUtils._internal() {
    print("DioUtils_internal()");
    if (dio == null) {
      print("DioUtils_options  new");
      BaseOptions options = BaseOptions(
        // baseUrl: "",
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        connectTimeout: 15000,
        receiveTimeout: 15000,
      );
      dio = Dio(options);
//      (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
      /// Fiddler抓包代理配置 https://www.jianshu.com/p/d831b1f7c45b
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return "PROXY 192.168.0.245:8888";
//      };
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
      dio.interceptors.add(new TokenInterceptor());
      dio.interceptors.add(new LoggingInterceptors());
    }
  }

  _requestHttp(
    BuildContext context,
    String method,
    String url,
    var params,
    Options options,
    bool showError,
    bool needList,
    Function onSucceed,
    Function onFailure,
  ) async {
    if (context != null) {
      LoadingView.show(context);
    }

    try {
      Response response;
      if (method == "GET") {
        response =
            await dio.get(url, queryParameters: params, options: options);
      } else {
        response = await dio.post(url, data: params, options: options);
      }

      print('received login data = ${response.data}');
      if (context != null) {
        LoadingView.hide();
      }
      if (response == null || response.data == null) {
        if (showError) {
          showToast("数据异常");
        }
        if (onFailure != null) {
          onFailure(10001, "数据异常");
        }
        return;
      }
      var result = response?.data;
      //您的账号已在其他设备上登录（返回登录界面）
      if (result['code'] == 102) {
        DioUtils.instance.dio.lock();
        DioUtils.instance.dio.clear();
        Toast.show("您的账号已在其他设备上登录（返回登录界面）");
        if (showError) {
          showToast(result['msg']);
        }
        if (onFailure != null) {
          onFailure(result['code'], result['msg']);
        }
        eventBus.fire(ExitApp());
        return;
      }
      if (result['code'] == 100) {
        DioUtils.instance.dio.lock();
        DioUtils.instance.dio.clear();
        Toast.show('token为空，登录失效');
        if (showError) {
          showToast("登录信息失效");
        }
        if (onFailure != null) {
          onFailure(result['code'], result['msg']);
        }
        eventBus.fire(ExitApp());
        return;
      }
      if (result['code'].toString() == '1') {
        if (onSucceed != null) {
          if(needList){
            onSucceed(result);
          }else{
            onSucceed(result['data']);
          }
        }
      } else {
        if (showError) {
          showToast(result['msg']);
        }
        if (onFailure != null) {
          onFailure(result['code'], result['msg']);
        }
      }
    } catch (error) {
      if (context != null) {
        LoadingView.hide();
      }
      print("请求结果异常：$url" + error.toString());
      if (showError) {
//        showToast('网络开小差了');
      }
      if (onFailure != null) {
        onFailure(10001, error.toString());
      }
    }
  }

  //post请求
  post(
    String url, {
    var data,
    BuildContext context,
    Options options,
    bool showError: true,
        bool needList: false,
    Function onSucceed,
    Function onFailure,
  }) async {
    _requestHttp(
        context, "POST", url, data, options, showError, needList, onSucceed, onFailure);
  }

  //get请求
  get(
    String url, {
    var data,
    BuildContext context,
    Options options,
    bool showError: true,
        bool needList: false,
    Function onSucceed,
    Function onFailure,
  }) async {
    _requestHttp(
        context, "GET", url, data, options, showError, needList, onSucceed, onFailure);
  }
}
