import 'dart:convert';



/*
通用模块
 */
import 'package:demo/pages/app_home.dart';
import 'package:demo/pages/login/login_page.dart';
import 'package:demo/pages/login/password_page.dart';
import 'package:demo/pages/login/register_page.dart';
import 'package:demo/tools/page/webview_html_page.dart';
import 'package:demo/tools/page/webview_page.dart';

import '404.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static String home = '/appHome';
  static String webViewPage = '/webView';
  static String htmlPage = '/htmlView';

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
      return WidgetNotFound();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) => AppHome()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      print(params);
      bool isNeed = (params['need']?.first.toString()=='1')?true:false;
      return WebViewPage(title: title, url: url, needToken: isNeed,);
    }));

    router.define(htmlPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String html = params['html']?.first;
      return WebViewHtmlPage(title: title, html: html);
    }));

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(MineRouter());
    _listRouter.add(SetRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}

abstract class IRouterProvider {
  void initRouter(Router router);
}

/*
传参 示例
 var parameter = {'title':'这是从登录页面传递过来的'};
 AppPush.pushWithParameter(context, FoundRouter.nextList, parameter);

 中间处理 示例
  router.define(registerPage, handler: Handler(handlerFunc: (_, params){
      var data = params['data']?.first;
      var params2 = json.decode(data);
      return RegisterPage(title: params2['title'],);
    }));

 */


/// ************************** 登录模块 **********************

class LoginRouter implements IRouterProvider {

  static String loginPage = '/login/login';
  static String registerPage = '/login/register';
  static String resetPasswordPage = '/login/password';
  static String videoApp = 'video/app';
  static String bindPhone = 'login/bindPhone';
  static String verificationPhone = 'login/verificationPhone';

  @override
  void initRouter(Router router) {
    //登录
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, params) => LoginPage()));
    //注册
    router.define(registerPage,
        handler: Handler(handlerFunc: (_, params) => RegisterPage()));
    //忘记密码
    router.define(resetPasswordPage, handler: Handler(handlerFunc: (_, params) {
      var data = params['data']?.first;
      var params2 = json.decode(data);
      return PasswordPage(
        type: params2['type'],
      );
    }));

  }
}

/// ************************** 首页模块 **********************


/// ************************** 发现 **********************



/// ************************** 个人中心 **********************

class MineRouter implements IRouterProvider {


  @override
  void initRouter(Router router) {

  }
}

/// ************************** 设置 **********************

class SetRouter implements IRouterProvider {
  static String setPage = '/set';
  static String setAbout = '/set/about';
  static String shopPage = '/set/shop';
  static String testScrollPage = '/set/scroll';

  @override
  void initRouter(Router router) {


  }
}

