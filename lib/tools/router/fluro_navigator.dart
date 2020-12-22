import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:demo/tools/router/application.dart';

import '../../public_header.dart';

/// fluro的路由跳转工具类
class AppPush {

  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  static void pushWithParameter(BuildContext context, String path, Map parameters,
      {bool replace = false, bool clearStack = false}) {
    unfocus();
    Application.router.navigateTo(context, '$path?data=${Uri.encodeComponent(json.encode(parameters))}', replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  static void pushWithParameterResult(BuildContext context, String path, Map parameters, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    unfocus();
    Application.router.navigateTo(context, '$path?data=${Uri.encodeComponent(json.encode(parameters))}', replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print('$error');
    });
  }

  static void pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    unfocus();
    Navigator.pop(context, result);
  }

  /// 跳到WebView页
  static void goWebViewPage(BuildContext context, String title, String url, int isNeedToken) {
    //fluro 不支持传中文,需转换
    push(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}&need=$isNeedToken');
  }

  /// 跳到WebView页
  static void goHtmlPage(BuildContext context, String title, String html) {
    //fluro 不支持传中文,需转换
    push(context, '${Routes.htmlPage}?title=${Uri.encodeComponent(title)}&html=${Uri.encodeComponent(html)}');
  }

  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }

  ///默认跳转
  static pushDefault(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  /// 替换页面 当新的页面进入后，之前的页面将执行dispose方法
  static pushDefaultReplacement(BuildContext context, Widget scene) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => scene,
        )
    );
  }

  /// 指定页面加入到路由中，然后将其他所有的页面全部pop
  static pushDefaultAndRemoveUntil(BuildContext context, Widget scene) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => scene,
        ), (route) => route == null
    );
  }

  ///默认带参数跳转
  static pushDefaultResult(BuildContext context, Widget scene, Function(Object) function) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    ).then((result){
      // 页面返回result为null
      if (result == null){
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  static popUntil(BuildContext context, Widget page, backPage) {
    Navigator.of(context).popUntil((route) {
      return route.settings.name == "ScreenToPopBackTo";
    });
  }

}
