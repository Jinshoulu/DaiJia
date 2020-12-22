

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

/// design/9暂无状态页面/index.html#artboard3
class StateLayout extends StatefulWidget {

  const StateLayout({
    Key key,
    @required this.type,
    this.hintText,
    this.imageSize = 120.0,
    this.image = '数据为空',
    this.showDownHeight = true,

  }):super(key: key);

  final StateType type;
  final String hintText;
  final double imageSize;
  final String image;
  final bool showDownHeight;

  @override
  _StateLayoutState createState() => _StateLayoutState();
}

class _StateLayoutState extends State<StateLayout> {

  String _img;
  String _hintText;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case StateType.order:
        _img = '数据为空';
        _hintText = '暂无订单';
        break;
      case StateType.goods:
        _img = '数据为空';
        _hintText = '暂无商品';
        break;
      case StateType.network:
        _img = '数据为空';
        _hintText = '无网络连接';
        break;
      case StateType.message:
        _img = '数据为空';
        _hintText = '暂时没有消息哦';
        break;
      case StateType.account:
        _img = '数据为空';
        _hintText = '马上添加提现账号吧';
        break;
      case StateType.bank:
        _img = '暂无银行卡';
        _hintText = '暂无银行卡';
        break;
      case StateType.loading:
        _img = '';
        _hintText = '';
        break;
      case StateType.limit:
        _img = '限时抢购为空';
        _hintText = '今日暂无抢购活动';
        break;
      case StateType.empty:
        _img = '数据为空';
        _hintText = '暂无数据';
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        widget.type == StateType.loading ? const CupertinoActivityIndicator(radius: 16.0) :
        Opacity(
            opacity: ThemeUtils.isDark(context) ? 0.5 : 1,
            child: Container(
              height: widget.imageSize,
              width: widget.imageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ImageUtils.getAssetImage(_img),
                ),
              ),
            )),
        const SizedBox(width: double.infinity, height: Dimens.gap_dp16,),
        Text(
          widget.hintText ?? _hintText,
          style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: Dimens.font_sp14),
        ),
        widget.showDownHeight?SizedBox(height: 120.0,):SizedBox(),
      ],
    );
  }
}

enum StateType {
  /// 订单
  order,
  /// 商品
  goods,
  /// 无网络
  network,
  /// 消息
  message,
  /// 无提现账号
  account,
  /// 无绑定银行卡
  bank,
  /// 加载中
  loading,
  /// 无限时抢购订单
  limit,
  /// 空
  empty
}