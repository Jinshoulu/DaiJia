

import 'package:flutter/foundation.dart';

class AppValue {

  /// 登录状态
  static const String login_state = 'loginState';

  /// token
  static const String token = 'token';

  /// refreshToken
  static const String refresh_token = 'refresh_token';

  /// token expiration
  static const String token_expiration = 'token_expiration';

  /// 保存的账号
  static const String login_account = 'login_account';

  /// 用户手机
  static const String user_phone = 'user_phone';

  /// 用户头像
  static const String user_header = 'user_header';

  /// 用户昵称
  static const String user_nickname = 'user_nickname';

  /// 当前选择位置
  static const String user_save_city = 'user_save_city';


  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = kReleaseMode;
  static bool isDriverTest  = false;
  static bool isUnitTest  = false;
  ///引导页
  static const String keyGuide = 'keyGuide';
  ///是不是夜间模式
  static const String theme = 'AppTheme';

}