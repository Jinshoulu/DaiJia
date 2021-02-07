

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
  static const String user_select_city = 'user_select_city';
  /// 当前选择位置 code
  static const String user_select_city_code = 'user_select_city_code';
  /// 当前选择位置 省
  static const String user_local_province = 'user_local_province';
  /// 当前选择位置 市
  static const String user_local_city = 'user_local_city';
  /// 当前选择位置 区 县
  static const String user_local_area = 'user_local_area';
  /// 当前选择详细地址
  static const String user_local_address = 'user_local_address';
  /// 当前选择位置 详细地址
  static const String user_local_long = 'user_local_long';
  /// 当前选择位置 详细地址
  static const String user_local_late = 'user_local_late';
  /// 当前选择位置 aoiName
  static const String user_aoi_name = 'user_aoi_name';
  ///省id
  static const String user_province_id = 'user_province_id';
  /// 市 id
  static const String user_city_id = 'user_city_id';
  /// 区 id
  static const String user_area_id = 'user_area_id';

  /// 区 id
  static const String user_j_push_id = 'user_j_push_id';
  /// 唯一 id
  static const String user_only_one_id = 'user_only_one_id';

  /******* 非必须 *******************/
  // 工号
  static const String user_work_code = 'user_work_code';

  // 司机余额
  static const String user_money_balance = 'user_money_balance';

  // 司机保障金
  static const String user_imoney_balance = 'user_imoney_balance';

  // 代驾分余额
  static const String user_branch_balance = 'user_branch_balance';

  // 积分余额
  static const String user_integral_balance = 'user_integral_balance';

  // 是否使用优推：1是2否
  static const String user_push_status = 'user_push_status';

  // 优推次数余额
  static const String user_push_count = 'user_push_count';

  // 优推时长个数余额
  static const String user_push_count2 = 'user_push_count2';

  // 审批状态：1未提交2未审批3审批通过4审批未通过
  static const String user_application_status = 'user_application_status';

  // 审批未通过原因
  static const String user_refund_reason = 'user_refund_reason';

  // 司机状态：1离线2未上线3已上线（空闲）4接单中5服务中
  static const String user_work_status = 'user_work_status';

  // 驾龄
  static const String user_work_age = 'user_work_age';

  // 驾驶证正本
  static const String user_image_file1 = 'user_image_file1';

  // 驾驶证副本
  static const String user_image_file2 = 'user_image_file2';

  // 身份证正面
  static const String user_image_file3 = 'user_image_file3';

  // 身份证反面
  static const String user_image_file4 = 'user_image_file4';

  // 代驾协议第一页
  static const String user_image_file5 = 'user_image_file5';

  // 代驾协议第二页
  static const String user_image_file6 = 'user_image_file6';

  // 代驾协议第三页
  static const String user_image_file7 = 'user_image_file7';

  // 工装半身照
  static const String user_image_file8 = 'user_image_file8';

  // 司机签名图片
  static const String user_image_sign = 'user_image_sign';

  // 注册时间
  static const String user_create_time = 'user_create_time';

  // 星级
  static const String user_star = 'user_star';

  // 终端id
  static const String user_tid = 'user_tid';

  // 轨迹id
  static const String user_trid = 'user_trid';

  // 高德webkey
  static const String user_key = 'user_key';

  // 服务id
  static const String user_sid = 'user_sid';


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
