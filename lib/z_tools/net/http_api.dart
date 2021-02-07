class Api {
  ///域名
//  static final baseApi = 'http://kaka.7oks.com:8080/index.php';
  static final baseApi = 'https://driving.7oks.com/app/';

  /// 通用接口 - - - - - - >
  ///获取七牛token
  static final qiniutoken = baseApi + "Upload/upload_token";
  ///客服聊天
  static final getCustomerUrl = baseApi + 'goods/customer';
  ///获取验证码
  static final getCodeUrl = baseApi + 'account/getverify';
  ///上传文件
  static final uploadUrl = baseApi + 'uploads/upload';
  ///获取省份
  static final getCityListUrl = baseApi + 'account/select_address';
  ///版本控制
  static final getVersionInfoUrl = baseApi + 'drivers/version';
  ///关于我们
  static final aboutUsUrl = baseApi + 'drivers/about';
  ///省市区级联列表
  static final selectAddressUrl = baseApi + 'account/select_address';

  ///上传移动轨迹
  static final uploadPointUrl = 'https://tsapi.amap.com/v1/track/point/upload';
  ///上传自己的位置
  static final uploadCurrentPointUrl = baseApi + 'driving/upaddress';

  ///协议 *********************** 协议 *********************

  ///司机协议
  static final drivingDelegateUrl = baseApi + 'account/agreement';
  ///用户服务协议
  static final userServiceDelegateUrl = baseApi + 'account/service';
  ///隐私协议
  static final privacyUrl = baseApi + 'account/policy';



  ///************************* 登录模块 ***************************

  ///登录
  static final loginUrl = baseApi + 'account/login';
  ///注册
  static final registerUrl = baseApi + 'account/register';
  ///忘记密码
  static final forgetPasswordUrl = baseApi + 'account/forgetpwd';
  ///刷新token
  static final refreshTokenUrl = baseApi + 'account/refertoken';
  ///上传签名
  static final uploadSignImageUrl = baseApi + 'account/upautograph';


  ///************************* 工作台 ***************************

  ///获取首页信息
  static final homeInfoUrl = baseApi + 'index/indexinfo';
  ///司机上下班
  static final homeDriverWorkingStatusUrl = baseApi + 'index/online';
  ///派单说明
  static final homePushOrderInstructionsUrl = baseApi + 'index/pushorder';
  ///积分变化记录
  static final homeIntegralRecordListUrl = baseApi + 'index/log_dintegral';
  ///获取推广赚钱奖励积分
  static final homeGetPushIntegralUrl = baseApi + 'index/integral';
  ///获取红包电子吊牌信息
  static final homeGetOfficialInfoUrl = baseApi + 'index/officialinfo';
  ///获取分享到QQ/微信信息
  static final homeShareInfoUrl = baseApi + 'index/shareinfo';
  ///上报分享结果
  static final homeUploadShareResultUrl = baseApi + 'index/upshare';
  ///获取小程序二维码 (扫码下单)
  static final homeAppletQRCodeUrl = baseApi + 'index/appletcode';
  ///获取奖励机制
  static final homeGetRewordUrl = baseApi + 'index/reward';
  ///获取赚钱攻略
  static final homeGetStrategyUrl = baseApi + 'index/strategy';
  ///获取代叫推广码信息
  static final homeGetPushCodeInfoUrl = baseApi + 'index/pushinfo';


  ///************************* 订单相关 ***************************

  ///获取充值套餐
  static final orderRechargePackageUrl = baseApi + 'orders/getpackage';
  ///生成充值订单
  static final orderCreateUrl = baseApi + 'orders/create_recorder';


  ///************************* 司机中心 ***************************

  ///司机中心
  static final centerIndexUrl = baseApi + 'centers/index';
  ///在线时长记录
  static final centerOnlineTimeUrl = baseApi + 'centers/log_donline';
  ///本周任务
  static final centerWeekTaskUrl = baseApi + 'centers/taskwork';
  ///本月任务
  static final centerMonthTaskUrl = baseApi + 'centers/taskmonth';
  ///获取优推相关内容
  static final centerPushInfoUrl = baseApi + 'centers/push';
  ///启用、禁用优推
  static final centerSetPushStatusUrl = baseApi + 'centers/pushstatus';
  ///兑换优推
  static final centerChangePushUrl = baseApi + 'centers/exchange';
  ///兑换优推记录
  static final centerChangePushRecordUrl = baseApi + 'centers/log_dpush';
  ///清空兑换优推记录
  static final centerClearChangePushRecordUrl = baseApi + 'centers/deldpush';
  ///优推使用记录
  static final centerUsePushRecordUrl = baseApi + 'centers/log_dusepush';
  ///清空优推使用记录
  static final centerClearUsePushRecordUrl = baseApi + 'centers/deldusepush';



  ///************************* 司机提现 ***************************

  ///获取完整授权
  static final withdrawInfoStrUrl = baseApi + 'withdraw/infostr';
  ///获取支付宝配置信息
  static final withdrawAlipayConfigUrl = baseApi + 'withdraw/alipay';
  ///获取微信配置信息
  static final withdrawWexinConfigUrl = baseApi + 'withdraw/wechat';
  ///第三方授权
  static final withdrawThridthUrl = baseApi + 'withdraw/auth';
  ///提现账号列表
  static final withdrawAccountListUrl = baseApi + 'withdraw/accountlist';
  ///获取提现相关信息
  static final withdrawInfoUrl = baseApi + 'withdraw/withdrawinfo';
  ///申请提现
  static final withdrawSubmitApplicationUrl = baseApi + 'withdraw/withdraw';



  ///************************* 司机学堂 ***************************

  ///司机学堂列表
  static final driverStudyClassList = baseApi + 'studys/studyslist';
  ///司机学堂详情
  static final driverClassDetail = baseApi + 'studys/studysview';
  ///司机学堂列表
  static final driverUploadStudyTime = baseApi + 'studys/upstudystime';


  ///************************* 通讯录 ***************************

  ///上传通讯录
  static final bookUpload = baseApi + 'phones/upphone';
  ///添加通讯录
  static final bookAdd = baseApi + 'phones/addphone';
  ///通讯录列表
  static final bookList = baseApi + 'phones/phonelist';
  ///单个删除通讯录
  static final bookDelete = baseApi + 'phones/delphone';


  ///************************* 公告管理 ***************************

  ///公告列表
  static final noticeList = baseApi + 'notices/noticelist';
  ///公告详情
  static final noticeDetail = baseApi + 'notices/noticeview';
  ///上传公告学习时间
  static final noticeUploadStudyTime = baseApi + 'notices/upnoticetime';


  ///************************* 个人中心 ***************************

  ///司机基本资料
  static final mineInfo = baseApi + 'drivers/driversinfo';
  ///修改头像
  static final mineModifyHeaderImageUrl = baseApi + 'drivers/editheadimg';
  ///修改昵称
  static final mineModifyNickNameUrl = baseApi + 'drivers/editnickname';
  ///修改驾龄
  static final mineDriverAgeUrl = baseApi + 'drivers/editwork_time';
  ///代驾分记录
  static final mineBranchRecordUrl = baseApi + 'drivers/log_dbranch';
  ///代驾分基本原则
  static final minePrincipleUrl = baseApi + 'drivers/principle';
  ///代驾分处罚标准
  static final minePunishUrl = baseApi + 'drivers/punish';
  ///获取账号余额、保障金、...
  static final mineBalanceUrl = baseApi + 'drivers/moneyinfo';
  ///保障金明细
  static final mineDimoneyRecordUrl = baseApi + 'drivers/log_dimoney';
  ///余额明细
  static final mineBalanceRecordUrl = baseApi + 'drivers/log_dmoney';
  ///订单提醒
  static final mineOrderTipsUrl = baseApi + 'drivers/log_dorder';
  ///电子工牌
  static final mineCodeCardUrl = baseApi + 'drivers/shareinfo';
  ///抽检记录
  static final mineSpotCheckRecordUrl = baseApi + 'drivers/checkslist';
  ///上传抽检图片 提交上传图片
  static final mineSubmitSpotCheckRecordUrl = baseApi + 'drivers/upchecksimg';
  ///获取收费标准
  static final mineGetPriceUrl = baseApi + 'drivers/driverprice';
  ///修改密码
  static final modifyPasswordUrl = baseApi + 'drivers/modifypwd';
  ///获取客服电话、司管电话
  static final mineCustomerPhonesUrl = baseApi + 'drivers/customerphone';
  ///提交审核资料
  static final mineSubmitApplicationInfoUrl = baseApi + 'drivers/postinfo';


  /*
   var data = {
      'phone': _editingControllerPhone.text,
      'password':_editingControllerPassword.text,
      'province_id':SpUtil.getString(AppValue.user_province_id,defValue: '')
    };
    DioUtils.instance.post(Api.centerIndexUrl,onSucceed: (response){

    },onFailure: (code,msg){

    });
   */


}
