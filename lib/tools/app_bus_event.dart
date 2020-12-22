import 'package:event_bus/event_bus.dart';


EventBus eventBus = new EventBus();

///退出登录
class ExitApp {
  ExitApp();
}


class SourceEvent {
  int index;
  dynamic data;

  SourceEvent(this.index, this.data);
}

class WxPayEvent {
  //同支付宝
  int type;
  int goodType = 0;
  dynamic data;

  WxPayEvent(
    this.type,
    this.goodType,
    this.data,
  );
}

class WxPayResultEvent {
  //同支付宝
  int type;
  int goodType = 0;

  WxPayResultEvent(this.type, this.goodType);
}

class AliPayEvent {
  /// 1 [LiveConfirmOrderPage] 直播商品支付
  /// 2 [ShopConfirmOrderPage] 除积分商品外支付确认页支付
  /// 3 [OrderListPage] ,[OrderDetailPage] 待支付 支付
  /// 4 [IntegralOrderListPage],[IntegralOrderDetailPage] 待支付 支付
  /// 5 [GroupListWidget],[OrderDetailPage] 待支付 支付
  /// 6 [MineRechargePage] 充值 支付
  /// 7 [IntegralOrderConfirmPage]
  int type;
  int goodType = 0; //商品类型 -1充值 1普通 2秒杀 3拼团 5云仓 100积分
  dynamic data;

  AliPayEvent(
    this.type,
    this.goodType,
    this.data,
  );
}

class AliPayResultEvent {
  int type;
  int goodType = 0;

  AliPayResultEvent(this.type, this.goodType);
}

class WxShareEvent {
  /// 1 观看直播[WatchLivePage] 分享到朋友圈
  /// 2 观看直播[WatchLivePage] 分享到 微信好友  打开小程序
  int type;
  dynamic data;

  WxShareEvent(this.type, this.data);
}

class ShareWxEvent {
  ///1.好友 2.朋友圈
  int type;

  ///1.图片 2.小程序 3.链接
  int shareType;
  dynamic data;

  ShareWxEvent(this.type, this.data, this.shareType);
}

