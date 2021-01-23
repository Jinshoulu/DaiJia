class Api {
  ///域名
//  static final baseApi = 'http://kaka.7oks.com:8080/index.php';
  static final baseApi = 'https://driving.7oks.com';

  ///获取七牛token
  static final qiniutoken = baseApi + "/app/Upload/upload_token";
  ///客服聊天
  static final getCustomerUrl = baseApi + '/app/goods/customer';
  ///获取验证码
  static final getCodeUrl = baseApi + '/app/user/verify';
  ///上传文件
  static final uploadUrl = baseApi + '/app/uploads/upload';
  ///获取省份
  static final getCityListUrl = baseApi + '/app/index/city_list';
  ///版本控制
  static final getVersionInfoUrl = baseApi + '/App/Drivers/version';
  ///关于我们
  static final aboutUsUrl = baseApi + '/App/Drivers/about';

  ///****************************************************


  ///完善资料
  static final completeInfoUrl = baseApi + '/App/Drivers/postinfo';
  ///登录
  static final loginUrl = baseApi + '/App/Drivers/postinfo';
  ///第三方登录
  static final thirdPartsLoginUrl = baseApi + '/App/Drivers/postinfo';
  ///验证码 - 登录
  static final codeLoginUrl = baseApi + '/App/Drivers/postinfo';
  ///注册
  static final registerUrl = baseApi + '/App/Drivers/postinfo';
  ///忘记密码
  static final forgetPasswordUrl = baseApi + '/App/Drivers/postinfo';
  ///刷新token
  static final refreshTokenUrl = baseApi + '/App/Drivers/postinfo';
  ///用户协议
  static final userDelegateUrl = baseApi + '/App/Drivers/postinfo';
  ///修改密码
  static final modifyPasswordUrl = baseApi + '/App/Drivers/postinfo';
  ///获取隐私政策
  static final privacyUrl = baseApi + '/App/Drivers/postinfo';
  ///个人资料
  static final userInfoUrl = baseApi + '/App/Drivers/postinfo';
  ///更换头像
  static final userChangeHeaderUrl = baseApi + '/App/Drivers/postinfo';
  ///更换绑定手机号
  static final userChangePhoneUrl = baseApi + '/App/Drivers/postinfo';
  ///第三方绑定手机号
  static final bindPhoneUrl = baseApi + '/App/Drivers/postinfo';


  ///抽检记录
  static final mineSpotCheckRecordUrl = baseApi + '/App/Drivers/checkslist';
  ///提交抽检记录
  static final mineSubmitSpotCheckRecordUrl = baseApi + '/App/Drivers/upchecksimg';




}
