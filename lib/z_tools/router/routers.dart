import 'dart:convert';



/*
通用模块
 */

import 'package:demo/app_pages/app_home.dart';
import 'package:demo/app_pages/login/login_page.dart';
import 'package:demo/app_pages/login/password_page.dart';
import 'package:demo/app_pages/login/register_page.dart';
import 'package:demo/app_pages/map/selectMap/AmapLocationAndSelectLocationPage.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverCenter.dart';
import 'package:demo/app_pages/workbench/exchangeCenter/ExchangeCenter.dart';
import 'package:demo/app_pages/workbench/single/mine_send_single.dart';
import 'package:demo/app_pages/workbench/push/create_order_scan.dart';
import 'package:demo/app_pages/workbench/push/push_money_and_score.dart';
import 'package:demo/app_pages/workbench/push/push_tags.dart';
import 'package:demo/app_pages/workbench/single/send_single.dart';
import 'package:demo/app_pages/workbench/taskCenter/TaskCenter.dart';
import 'package:demo/z_tools/page/webview_html_page.dart';
import 'package:demo/z_tools/page/webview_page.dart';

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
    _listRouter.add(HomeRouter());
    _listRouter.add(OrderRouter());
    _listRouter.add(DriverRouter());
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
class HomeRouter implements IRouterProvider {

  static String sendSingle = '/single';
  static String mineSingle = '/mineSingle';
  static String selectMap = '/single/map';

  static String pushMoneyAndScore = '/moneyAndScore';
  static String pushTags = '/pushTags';
  static String oderScan = '/orderScan';

  static String driverCenter = '/driverCenter';

  static String taskCenter = '/taskCenter';

  static String exchangeCenter = '/exchangeCenter';

  @override
  void initRouter(Router router) {
    //派单
    router.define(sendSingle, handler: Handler(handlerFunc: (_, params) => SendSingle()));
    //我要派单
    router.define(mineSingle, handler: Handler(handlerFunc: (_, params) => MineSendSingle()));
    //选择地图
    router.define(selectMap, handler: Handler(handlerFunc: (_, params) => AmapLocationAndSelectLocationPage()));
    //推广赚钱
    router.define(pushMoneyAndScore, handler: Handler(handlerFunc: (_, params) => PushMoneyAndScore()));
    //电子吊牌
    router.define(pushTags, handler: Handler(handlerFunc: (_, params) => PushTags()));
    //扫码下单
    router.define(oderScan, handler: Handler(handlerFunc: (_, params) => CreateOrderScan()));

    //司机中心
    router.define(driverCenter, handler: Handler(handlerFunc: (_, params) => DriverCenter()));

    //任务中心
    router.define(taskCenter, handler: Handler(handlerFunc: (_, params) => TaskCenter()));

    //优推兑换
    router.define(exchangeCenter, handler: Handler(handlerFunc: (_, params) => ExchangeCenter()));


  }
}

/// ************************** 订单 **********************
class OrderRouter implements IRouterProvider {

  static String sendSingle = '/single';


  @override
  void initRouter(Router router) {
    //派单
    router.define(sendSingle, handler: Handler(handlerFunc: (_, params) => SendSingle()));

  }
}


/// ************************** 司机 **********************
class DriverRouter implements IRouterProvider {

  static String sendSingle = '/single';


  @override
  void initRouter(Router router) {
    //派单
    router.define(sendSingle,
        handler: Handler(handlerFunc: (_, params) => SendSingle()));

  }
}



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

