import 'dart:io';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:demo/app_pages/app_home.dart';
import 'package:demo/app_pages/login/login_page.dart';
import 'package:demo/provider/app_status.dart';
import 'package:demo/provider/user_info.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/net/log_utils.dart';
import 'package:demo/z_tools/other/i18n.dart';
import 'package:demo/z_tools/router/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_picker/PickerLocalizationsDelegate.dart';
import 'package:fluwx/fluwx.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'app_pages/login/received_notifcation.dart';
import 'z_tools/app_bus_event.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await enableFluttifyLog(false);
  await AmapService.instance.init(
    iosKey: 'a81c95294fbdf396766444617b96e166',
    androidKey: 'f2ecc8b1819a64cdb3910a21b694a854',
  );
  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  ///初始化通用数据
  await SpUtil.getInstance();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>UserInfo(),),
          ChangeNotifierProvider(create: (_)=>ThemeProvider()),
          ChangeNotifierProvider(create: (_)=>AppStatus()),
        ],
        child: MyApp(),)
  );

}

class MyApp extends StatefulWidget {
  final Widget home;

  MyApp({this.home}) {
    Log.init();
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  BuildContext _buildContext;

  JPush jpush = new JPush();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    registerWxApi(appId: "wx30a1a2ffb5fdc3c3", universalLink: "https://www.astgo.com/qq_conn/101934822");

    jpush.setup(
      appKey: "0391296c67f5adcba7f57ebe",
      channel: "developer-default",
      production: false,
      debug: true, //是否打印debug日志
    );
    jpush.applyPushAuthority(new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    jpush.getRegistrationID().then((value) {
      print("rid=>" + '$value');
      SpUtil.putString(AppValue.user_j_push_id, value);
    });
//    jpush.getLaunchAppNotification();
    _getmsg();
  }

  loadNotification()async{
    notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
    // of the `IOSFlutterLocalNotificationsPlugin` class
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            debugPrint('notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload);
        });
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // 接收通知回调方法。
  void _getmsg() {
    jpush.addEventHandler(
      //接收通知消息
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("监听的信息 ----------> ${message}");
        operationData(message);
      },
      // 点击通知回调方法。     
      /*
      {alert: 有新用户发布了开锁订单，请前往查看接单, extras: {cn.jpush.android.ALERT_TYPE: -1, cn.jpush.android.NOTIFICATION_ID: 123, cn.jpush.android.MSG_ID: 123, cn.jpush.android.ALERT: 有新用户发布了开锁订单，请前往查看接单, cn.jpush.android.EXTRA: {"id":"123","type":"1"}}, title: 抢单订单通知}   
       */
      onOpenNotification: (Map <String, dynamic> message) async {
        if(Platform.isIOS){
          return;
        }
        print("点击推送获得消息 ----------> ${jsonDecode(message['extras']['cn.jpush.android.EXTRA'])}");
        var messageDic = jsonDecode(message['extras']['cn.jpush.android.EXTRA']);
        ///只有在登录状态才接收通知
        if(!SpUtil.getBool(AppValue.login_state)){
          return;
        }
        eventBus.fire(JPushNotification(messageDic['type'].toString(),messageDic['tid'].toString()));
      },
      //自定义消息
      onReceiveNotification: (Map <String, dynamic> message) async {
        print("自定义消息 ----------> ${json.encode(message)}");
        operationData(message);
      },
    );
  }



  operationData(Map message){

    ///只有在登录状态才接收通知
    if(!SpUtil.getBool(AppValue.login_state)){
      return;
    }

    String type = '';
    String tid = '';
    String content = '';
    Map<String,String> messageData;
    if(Platform.isIOS){
      var dic = message['extras'];
      tid = dic['tid'].toString();
      type = dic['type'].toString();
      content = message['content'].toString();
    }else{
      var dic = message['extras'];
      var messageDic = jsonDecode(message['extras']['cn.jpush.android.EXTRA']);
      type = messageDic['type'].toString();
      tid = messageDic['tid'].toString();
      content = message['message'].toString();
    }
    ///防止同一个通知无线循环推送的问题
    if(tid==null||tid=='null'){
      return;
    }
    if(content==null||content=='null'){
      return;
    }
    if(SpUtil.getString('saveMessageid') == tid){
      return;
    }
    SpUtil.putString('saveMessageid', tid);
    messageData = {
      'type':type,
      'tid':tid,
      'message':content,
    };
    _showNotification(tid, type, '标兵代驾', content, messageData);
  }

  Future<void> _showNotification(messageId,type,String title,content, var messageDic) async {

    var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    var localNotification = LocalNotification(
        id: int.parse(messageId),
        title: title,
        buildId: 1,
        content: content,
        fireTime: fireDate,
        subtitle: '',
        badge: 0,
        soundName: 'region',
        extra: messageDic
    );
    await jpush.sendLocalNotification(localNotification).then((res) {
      setState(() {});
    });

  }


  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return OKToast(
        child: ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          child: Consumer<ThemeProvider>(
            builder: (_, provider, __) {
              return MaterialApp(
                title: '标兵代驾',
//              showPerformanceOverlay: true, //显示性能标签
                debugShowCheckedModeBanner: false,
                // 去除右上角debug的标签
//                checkerboardRasterCacheImages: true,
//              showSemanticsDebugger: true, // 显示语义视图
//              checkerboardOffscreenLayers: true, // 检查离屏渲染
                theme: provider.getTheme(),
                darkTheme: provider.getTheme(isDarkMode: true),
                themeMode: provider.getThemeMode(),
                home: determinePushPage(),
                onGenerateRoute: Application.router.generator,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalEasyRefreshLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  PickerLocalizationsDelegate.delegate,
                ],
                supportedLocales: const [
                  Locale('zh', 'CN'),
                  Locale('en', 'US')
                ],
                localeResolutionCallback: S.delegate.resolution(),
                builder: (context, child) {
                  /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
                    child: child,
                  );
                },
              );
            },
          ),
        ),

        /// Toast 配置
        backgroundColor: Colors.black54,
        textPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.center);
  }

  determinePushPage(){
    if(SpUtil.getBool(AppValue.login_state,defValue: false)==true){
      return AppHome();
    }else{
      return LoginPage();
    }
  }
}


