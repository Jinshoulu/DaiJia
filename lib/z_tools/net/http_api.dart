class Api {
  ///域名
//  static final baseApi = 'http://kaka.7oks.com:8080/index.php';
  static final baseApi = 'http://subangapp.7oks.com';

  ///获取七牛token
  static final qiniutoken = baseApi + "/app/Upload/upload_token";

  ///请求接口
  static final testUrl = '';

  ///客服聊天
  static final getCustomerUrl = baseApi + '/app/goods/customer';

  ///获取验证码
  static final getCodeUrl = baseApi + '/app/user/verify';

  ///上传文件
  static final uploadUrl = '/tools/uploads/uploads';

  ///获取省份
  static final getCityListUrl = baseApi + '/app/index/city_list';

  ///完善资料
  static final completeInfoUrl = '/masters/masters/addInfo';

  ///登录
  static final loginUrl = baseApi + '/app/user/login';

  ///第三方登录
  static final thirdPartsLoginUrl = baseApi + '/app/user/app_wx_login';

  ///验证码 - 登录
  static final codeLoginUrl = baseApi + '/app/user/code_login';

  ///注册
  static final registerUrl = baseApi + '/app/user/register';

  ///忘记密码
  static final forgetPasswordUrl = baseApi + '/app/user/forget_password';

  ///刷新token
  static final refreshTokenUrl = baseApi + '/app/user/refer_token';

  ///用户协议
  static final userDelegateUrl = '/masters/masters/protocol';

  ///修改密码
  static final modifyPasswordUrl = '/masters/masters/savePassword';

  ///获取隐私政策
  static final privacyUrl = '/masters/masters/privacy';

  ///个人资料
  static final userInfoUrl = baseApi + '/app/user/user_detail';

  ///更换头像
  static final userChangeHeaderUrl = '/masters/masters/updateHead';

  ///更换绑定手机号
  static final userChangePhoneUrl = baseApi + '/app/user/bind_phone';

  ///第三方绑定手机号
  static final bindPhoneUrl = baseApi + '/app/user/bind_phone';

  ///首页 - - 布局控制
  static final homeLayout = baseApi + '/app/index/layout';

  ///首页 - - 商品组件详情
  static final homeGoodsComponent = baseApi + '/app/goods/component';

  ///首页 - - 商品列表 - - 普通商品
  static final homeGoodsNormal = baseApi + '/app/goods/index';

  ///首页 - - 爆款礼包商品列表
  static final homeGoodsHot = baseApi + '/app/goods/package';

  ///首页 - - 秒杀商品
  static final homeGoodsSpike = baseApi + '/app/goods/spike';

  ///首页 - - 拼团商品列表
  static final homeGoodsPin = baseApi + '/app/goods/groupgoods';

  ///首页 - - 拼团 团队列表
  static final homePinTeamList = baseApi + '/app/goods/team_list';

  ///首页 - - 营销活动详情
  static final homeMark = baseApi + '/app/index/market';

  ///首页 - - 轮播
  static final homeSlideList = baseApi + '/app/index/slideshow_list';

  ///首页 - - 标签
  static final homeLabelList = baseApi + '/app/index/label_list';

  ///首页 - - 菜单
  static final homeMenuList = baseApi + '/app/index/menu_list';

  ///首页 - - 公告
  static final homeNotice = baseApi + '/app/index/notice_list';

  ///首页 - - 广告位
  static final homeAdvList = baseApi + '/app/index/adv_list';

  ///首页 - - 店铺列表
  static final homeShopList = baseApi + '/app/index/shop_list';

  ///首页 - - 店铺详情
  static final homeShopDetail = baseApi + '/app/index/shop_detail';

  ///首页 - - 店铺图片
  static final homeShopPhotos = baseApi + '/app/index/shop_photo';

  ///商品 - - 商品详情
  static final goodsDetail = baseApi + '/app/goods/view';

  ///商品 - - 商品收藏与取消收藏
  static final goodsCollection = baseApi + '/app/goods/favorites';

  ///商品 - - 商品收藏列表
  static final goodsCollectionList = baseApi + '/app/goods/favorites_list';

  ///商品 - - 商品搜索关键字
  static final goodsKeywords = baseApi + '/app/goods/keywords';

  ///商品 - - 商品提交订单
  static final goodsSubmitOrder = baseApi + '/app/order/create';

  ///商品 - - 商品评论
  static final goodsComment = baseApi + '/app/goods/comment';

  ///首页 - - 签到
  static final homeSignUrl = '/masters/notices/sings';

  ///首页 - - 是否签到
  static final homeGetSignStatusUrl = '/masters/masters/checkSings';

  ///首页 - - 签到列表
  static final homeSignHistoryUrl = '/masters/masters/singsList';

  ///首页 - - 未完成订单数
  static final homeUndoneOrderNumberUrl = '/masters/order/sum';

  ///发现 - - 分类列表
  static final foundCategoryList = baseApi + '/app/discover/category_list';

  ///发现 - - 文章列表
  static final foundArticleList = baseApi + '/app/discover/article_list';

  ///发现 - - 文章详情
  static final foundArticleDetail = baseApi + '/app/discover/article_detail';

  ///发现 - - 动态信息列表
  static final foundDynamicList = baseApi + '/app/discover/dynamic_list';

  ///发现 - - 分享记录次数
  static final foundSetShareCount = baseApi + '/app/discover/set_share';

  ///发现 - - 点赞
  static final foundSetPraiseCount = baseApi + '/app/discover/set_praise';

  ///发现 - - 评论
  static final foundSetCommentCount = baseApi + '/app/discover/set_comment';

  ///发现 - - 评论列表
  static final foundSetCommentList = baseApi + '/app/discover/comment_list';

  ///我的 - - 收获地址列表
  static final mineAddressList = baseApi + '/app/goods/address';

  ///我的 - - 编辑或者添加收货地址
  static final mineAddAddress = baseApi + '/app/goods/post_address';

  ///我的 - - 设置为默认地址
  static final mineSetDefaultAddress = baseApi + '/app/goods/set_address_status';

  ///我的 - - 删除收货地址
  static final mineDeleteAddress = baseApi + '/app/goods/del_address';

  ///我的 - - 国外收货地址
  static final mineAddressOutCountry = baseApi + '/app/goods/address_foreign';

  ///我的 - - 国内地址三级联动
  static final mineAddressCity = baseApi + '/app/goods/cascade_index';

  ///我的 - - 优惠券
  static final mineCouponList = baseApi + '/app/coupon/index';

  ///我的 - - 领取优惠券
  static final mineGetCoupon = baseApi + '/app/coupon/receive';

  ///我的 - - 修改头像
  static final mineModifyHeaderImage = baseApi + '/app/user/update_head';

  ///我的 - - 修改手机号
  static final mineModifyPhone = baseApi + '/app/user/update_phone';

  ///我的 - - 修改昵称
  static final mineModifyNickname = baseApi + '/app/user/update_nickname';

  ///我的 - - 团队列表
  static final mineTeamList = baseApi + '/app/goods/team_list';

  ///我的 - - 充值
  static final mineRecharge = baseApi + '/app/user/set_balance';

  ///我的 - - 我的收益
  static final mineIncome = baseApi + '/app/user/my_profit_stock';

  ///我的 - - 提现
  static final mineTixian = baseApi + '/app/user/withdraw';

  ///我的 - - 收入总额
  static final mineAllMoney = baseApi + '/app/user/income';

  ///我的 - - 提现记录
  static final mineTixianList = baseApi + '/app/user/withdraw_list';

  ///我的 - - 获取积分 分享商品或分享直播之前调用  用以记录
  static final mineShareGetScore = baseApi + '/app/user/share_record';

  ///我的 - - 新人红包
  static final mineNewRedPacket = baseApi + '/app/user/get_packet';

  ///我的 - - 我的邀请人列表
  static final mineInviteList = baseApi + '/app/user/viplist';

  ///我的 - - 业绩统计
  static final mineAchievement = baseApi + '/app/user/my_profit_achievement';


  ///积分 - - 积分商品列表
  static final integralGoodsList = baseApi + '/app/GoodsIntegral/goods_list';

  ///积分 - - 积分详情
  static final integralGoodsDetail = baseApi + '/app/GoodsIntegral/goods_detail';

  ///积分 - - 下单确认
  static final integralGoodsConfirm = baseApi + '/app/GoodsIntegral/confirm';

  ///积分 - - 创建订单
  static final integralGoodsCreateOrder = baseApi + '/app/GoodsIntegral/create';

  ///积分 - - 订单付款
  static final integralOrderPay = baseApi + '/app/GoodsIntegral/pay';

  ///积分 - - 订单列表
  static final integralOrderList = baseApi + '/app/GoodsIntegral/index';

  ///积分 - - 订单详情
  static final integralOrderDetail = baseApi + '/app/GoodsIntegral/view';

  ///积分 - - 订单物流
  static final integralOrderLogistics =
      baseApi + '/app/GoodsIntegral/logistics';

  ///积分 - - 确认收货
  static final integralOrderConfirm = baseApi + '/app/GoodsIntegral/receipt';

  ///积分 - - 订单评论商品
  static final integralOrderCommentGoods =
      baseApi + '/app/GoodsIntegral/comment';

  ///积分 - - 订单评论提交
  static final integralOrderSubmitComment =
      baseApi + '/app/GoodsIntegral/comment';

  ///积分 - - 订单申请售后 获取数据
  static final integralRefundData = baseApi + '/app/GoodsIntegral/apply';

  ///积分 - - 申请售后 数据提交
  static final integralRefundSubmit = baseApi + '/app/GoodsIntegral/apply';

  ///积分 - - 售后列表
  static final integralRefundList = baseApi + '/app/GoodsIntegral/apply_list';

  ///积分 - - 售后详情
  static final integralRefundDetail = baseApi + '/app/GoodsIntegral/apply_view';

  ///积分 - - 售后发货
  static final integralRefundSendShip = baseApi + '/app/GoodsIntegral/ship';

  ///购物车 - - 购物车列表
  static final cartList = baseApi + '/app/cart/index';

  ///购物车 - - 添加购物车
  static final cartAddGoods = baseApi + '/app/cart/add';

  ///购物车 - - 增加或者减少数量
  static final cartModifyNumber = baseApi + '/app/cart/incdec';

  ///购物车 - - 删除购物车
  static final cartDeleteGoods = baseApi + '/app/cart/del_cart';

  ///购物车 - - 下单
  static final cartCreateOrder = baseApi + '/app/order/confirm';

  ///购物车 - - 获取满减信息
  static final cartGetDiscount = baseApi + '/app/cart/discount';

  ///订单 - - 订单支付
  static final orderPay = baseApi + '/app/order/pay';

  ///订单 - - 取消订单
  static final orderCancel = baseApi + '/app/order/close';

  ///订单 - - 删除订单
  static final orderDelete = baseApi + '/app/order/del_order';

  ///订单 - - 我的订单列表
  static final orderList = baseApi + '/app/order/index';

  ///订单 - - 我的拼团订单
  static final orderPinList = baseApi + '/app/order/pin_index';

  ///订单 - - 订单详情
  static final orderDetail = baseApi + '/app/order/view';

  ///订单 - - 确认收货
  static final orderDone = baseApi + '/app/order/receipt';

  ///订单 - - 订单物流信息
  static final orderLogistics = baseApi + '/app/order/logistics';

  ///订单 - - 我的最新物流
  static final orderNewLogistics = baseApi + '/app/order/received';

  ///订单 - - 订单评价 获取评价商品
  static final orderCommentGoodsList = baseApi + '/app/order/comment';

  ///订单 - - 订单评价提交
  static final orderSubmitComment = baseApi + '/app/order/comment';

  ///订单 - - 推客订单
  static final orderPushList = baseApi + '/app/order/recommend';

  ///订单 - - 申请售后 获取数据
  static final orderApplication = baseApi + '/app/refund/apply';

  ///订单 - - 申请售后 提交
  static final orderSubmitRefund = baseApi + '/app/refund/apply';

  ///订单 - - 售后 列表
  static final orderRefundList = baseApi + '/app/refund/index';

  ///订单 - - 售后 取消
  static final orderRefundCancel = baseApi + '/app/refund/close';

  ///订单 - - 售后 删除
  static final orderRefundDelete = baseApi + '/app/refund/del_refund';

  ///订单 - - 售后 详情
  static final orderRefundDetail = baseApi + '/app/refund/view';

  ///订单 - - 售后 获取物流公司
  static final orderRefundLogisticsCompany = baseApi + '/app/refund/ship';

  ///订单 - - 售后 提交物流单号
  static final orderRefundSubmitOrderNo = baseApi + '/app/refund/cloud';

  ///云仓 - - 商城
  static final yunShop = baseApi + '/app/goods/cloud';

  ///云仓 - - 商品详情
  static final yunDetail = baseApi + '/app/goods/view';

  ///云仓 - - 云仓订单列表
  static final yunOrderList = baseApi + '/app/order/cloud';

  ///云仓 - - 云仓礼包数量变化记录
  static final yunGiftChangeRecordList = baseApi + '/app/cloud/gift';

  ///云仓 - - 云仓下级列表
  static final yunNextSonList = baseApi + '/app/cloud/sub';

  ///云仓 - - 云仓等级列表
  static final yunLevelList = baseApi + '/app/cloud/grade';

  ///云仓 - - 申请创建云仓
  static final yunCreate = baseApi + '/app/cloud/upgrade_grade';

  ///问题列表
  static final questionListUrl = '/masters/masters/questionList';

  ///问题详情
  static final questionDetailUrl = '/masters/masters/questionDetail';

  ///意见反馈
  static final submitQuestionUrl = baseApi + '/app/user/add_feedback';

  ///关于我们
  static final aboutUrl = '/masters/masters/about';

  ///获取通知消息
  static final noticeListUrl = '/masters/order/getNotifyList';

  ///退出登录
  static final exitUrl = '/masters/masters/logout';

  ///版本更新
  static final getVersionInfoUrl = '/masters/masters/getversion';

  ///获取分享图片链接
  static final getShareImageUrl = baseApi + '/app/user/share';

  ///奖品列表
  static final dialList = baseApi + '/app/dial/get_dial';

  ///抽奖
  static final dialPrize = baseApi + '/app/dial/get_prize';

  ///实体商品收货地址
  static final dialAddress = baseApi + '/app/dial/goods_address';

  ///中奖名单
  static final dialRecord =  baseApi + '/app/dial/get_record';

  ///用户中奖记录
  static final dialUserRecord =  baseApi + '/app/dial/get_user_record';

  ///公司简介
  static final companyIntroduction = baseApi + '/app/user/company_introduction';

  ///服务条款
  static final serviceTerms = baseApi + '/app/user/service_terms';

  ///隐私政策
  static final privacyPolicy = baseApi + '/app/user/privacy_policy';

  ///注册协议
  static final registerProtocol = baseApi + '/app/user/register_protocol';

  ///平台参数
  static final appParams = baseApi + '/app/user/get_params';

  ///版本号
  static final appVersion = baseApi + '/app/user/get_version';

  ///自营商品上传说明
  static final liveGoodsInfo = baseApi + '/app/index/live_goods_info';

  ///优惠券使用说明
  static final couponInfo = baseApi + '/app/index/coupon_info';

  //**************************************************************
  //直播热门列表
  static final hot_live = baseApi + '/app/live/hot_live';

  //直播分类列表
  static final live_list = baseApi + '/app/live/live_list';

  //直播列表
  static final live_group = baseApi + '/app/live/live_group';

  //添加自营商品
  static final add_goods = baseApi + '/app/liveGoods/add_goods';

  //我的未审核商品
  static final anchor_goods = baseApi + '/app/liveUser/anchor_goods';

  //商品分类
  static final category = baseApi + '/app/liveGoods/category';

  //我的货源、自营、全部商品
  static final livemy_goods = baseApi + '/app/liveUser/livemy_goods';

  //申请主播
  static final add_live_user = baseApi + '/app/live/add_live_user';

//主播状态
  static final live_user_status = baseApi + '/app/live/live_user_status';

  //主播直播页面
  static final live_user = baseApi + '/app/live/live_user';

  //用户进入房间
  static final client_login = baseApi + '/app/bind/client_login';

  //用户退出房间
  static final client_logout = baseApi + '/app/bind/client_logout';

  //主播推送商品。
  static final push_goods = baseApi + '/app/live/push_goods';

  //主播停止推送商品
  static final end_push_goods = baseApi + '/app/live/end_push_goods';

  //主播推送优惠券
  static final push_coupon = baseApi + '/app/live/push_coupon';

  //主播停止推送优惠券
  static final end_push_coupon = baseApi + '/app/live/end_push_coupon';

  //主播推送活动
  static final push_activity = baseApi + '/app/live/push_draw';

  //主播停止推送活动
  static final end_push_activity = baseApi + '/app/live/end_push_draw';

  //主播添加底部图片
  static final add_bottom_img = baseApi + '/app/live/add_bottom_img';

  //主播移除底部图片
  static final del_bottom_img = baseApi + '/app/live/del_bottom_img';

  //开始直播页面可选择商品、活动、优惠
  static final live_data = baseApi + '/app/live/live_data';

  //主播发红包
  static final push_bonus = baseApi + '/app/live/push_bonus';

  //主播发红包
  static final end_push_bonus = baseApi + '/app/live/revoke_bonus';

  //开始直播
  static final live_start = baseApi + '/app/live/index';

  //用户抽奖
  static final luck_draw = baseApi + '/app/LiveInteract/luck_draw';

  //用户领红包
  static final rob_bonus = baseApi + '/app/LiveInteract/rob_bonus';

  //用户观看直播页面
  static final live_user_info = baseApi + '/app/live/live_user_info';

  //用户在直播间发送聊天消息
  static final send_msg = baseApi + '/app/bind/say';

  //用户关注主播
  static final follow_anchor = baseApi + '/app/user/follow_anchor';

  //用户关注主播
  static final anchor_list = baseApi + '/app/live/anchor_list';

  //主播带货排行
  static final live_user_ranking = baseApi + '/app/live/live_user_ranking';

  //用户送礼物
  static final giving_gifts = baseApi + '/app/LiveInteract/giving_gifts';

  //礼物列表
  static final gift_list = baseApi + '/app/live/gift_list';

  //货源商品列表
  static final source_list = baseApi + '/app/live/source_list';

  //货源商品详情
  static final source_detail = baseApi + '/app/liveGoods/source_detail';

  //添加我的商品
  static final add_livemy_goods = baseApi + '/app/liveUser/add_livemy_goods';

  //用户中奖提交收货地址
  static final commit_address = baseApi + '/app/LiveInteract/address';

  //确认下单
  static final live_order_confirm = baseApi + '/app/LiveOrder/confirm';

  //创建订单
  static final live_order_create = baseApi + '/app/LiveOrder/create';

  //订单付款
  static final live_order_pay = baseApi + '/app/LiveOrder/pay';

  //订单取消
  static final live_order_close = baseApi + '/app/LiveOrder/close';

  //直播间分享
  static final live_share_link = baseApi + '/app/LiveShare/create_link';

  //主播协议
  static final live_agreement = baseApi + '/app/live/anchor';

  //我的粉丝列表
  static final live_fans_list = baseApi + '/app/LiveUser/fans_list';

  //主播个人中心
  static final live_user_center = baseApi + '/app/LiveUser/user_info';

  //主播数据统计
  static final live_data_statistics = baseApi + '/app/LiveUser/data_statistics';

  //直播搜索
  static final live_search = baseApi + '/app/live/search';

  //签到
  static final sign = baseApi + '/app/user/set_sign';

  //积分任务
  static final score_task = baseApi + '/app/user/score_task';

  //积分任务
  static final score_list = baseApi + '/app/user/score_list';

  //主播历史直播列表
  static final record_list = baseApi + '/app/live/record_list';

  //取消积分售后
  static final refund_close_integral =
      baseApi + '/app/GoodsIntegral/refund_close';

  //删除售后
  static final del_refund_integral = baseApi + '/app/GoodsIntegral/del_refund';

  //订单确认收货
  static final receipt_refund_integral = baseApi + '/app/GoodsIntegral/receipt';

  //订单评论（获取订单商品列表）
  static final comment_integral = baseApi + '/app/GoodsIntegral/comment';

  //积分 退货售后 发货ha
  static final ship_integral = baseApi + '/app/GoodsIntegral/ship';

  //积分订单 取消
  static final close_order_integral = baseApi + '/app/GoodsIntegral/close';

  //积分订单 删除
  static final del_order_integral = baseApi + '/app/GoodsIntegral/del_order';

  //商品分类及分类下商品
  static final homeCategoryUrl = baseApi + '/app/goods/category';

  //修改密码
  static final modify_password = baseApi + '/app/user/update_password';
  //积分商品评论列表
  static final comment_list_integral = baseApi + '/app/GoodsIntegral/comment_list';


}
