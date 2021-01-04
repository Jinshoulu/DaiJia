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
import 'package:demo/z_tools/router/lanch.dart';
import 'package:demo/z_tools/router/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_picker/PickerLocalizationsDelegate.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


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
    return LoginPage();
    if(SpUtil.getBool(AppValue.login_state,defValue: false)){
      return LoginPage();
    }else{
      return AppHome();
    }
  }
}


