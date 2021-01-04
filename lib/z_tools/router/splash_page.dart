
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flustars/flustars.dart';

import '../../public_header.dart';
import 'fluro_navigator.dart';
import 'routers.dart';


enum ShowMode{
  oneImage, //一张图
  waiteImage, //广告等待
  sliderImage //滑动到最后一张
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  ShowMode mode = ShowMode.waiteImage;
  //定时
  int timeCount = 5;
  Timer _timer;

  //滑动图数组
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription _subscription;

  BuildContext _buildContext;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ///初始化通用数据
      await SpUtil.getInstance();
      // 由于SpUtil一开始未初始化，所以MaterialApp获取的为默认主题配置，这里同步一下。
      Provider.of<ThemeProvider>(context, listen: false).syncTheme();
      //是否显示引导页
      /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
      if(mode==ShowMode.waiteImage){
        _guideList.forEach((image) {
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
      }
      _initSplash();
    });

  }


  @override
  void dispose() {
    _subscription?.cancel();
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  void _initSplash() {

    if(mode==ShowMode.waiteImage){
      _timer = Timer.periodic(Duration(seconds: 1), (value){
        timeCount--;
        if(timeCount<=1){
          _goLogin();
        }
        setState(() {});
      });
    }else{
      _subscription = Stream.value(1).delay(Duration(milliseconds: 1500)).listen((_) {
        _goLogin();
      });
    }
  }


  void _goLogin() {

    if(SpUtil.getBool(AppValue.login_state,defValue: false)){
      AppPush.push(context, Routes.home, replace: true);
    }else{
      AppPush.push(context, LoginRouter.loginPage, replace: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Material(
        color: ThemeUtils.getBackgroundColor(context),
        child: createShowMode()
    );
  }

  createShowMode(){
    switch(mode){
      case ShowMode.oneImage:
        {
          return FractionallyAlignedSizedBox(
              child: const LoadAssetImage('launch_image',fit: BoxFit.fill,)
          );
        }
        break;
      case ShowMode.waiteImage:
        {
          return  Stack(
            children: <Widget>[
              Positioned(
                left: 0,top: 0,right: 0,bottom: 0,
                child: Container(
                  child: Swiper(
                    itemCount: _guideList.length,
                    pagination: new SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          color: Colors.black54,
                          activeColor: Colors.white,
                        )),
                    scrollDirection: Axis.horizontal,
                    autoplay: true,
                    itemBuilder: (_, index) {
                      return LoadAssetImage(
                        _guideList[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 30,
                  right: 0,
                  child: FlatButton(
                      onPressed: (){
                        _goLogin();
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: AppColors.greenColor
                        ),
                        child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: Dimens.font_sp14
                              ),
                              text: '($timeCount)s',
                              children: [
                                TextSpan(
                                  text: '点击进入',
                                  style: TextStyle(
                                    fontSize: Dimens.font_sp14
                                  )
                                )
                              ]
                            )
                        ),
                      )
                  )
              )
            ],
          );

        }
        break;
      case ShowMode.sliderImage:
        {
          return  Swiper(
            key: const Key('swiper'),
            itemCount: _guideList.length,
            loop: false,
            itemBuilder: (_, index) {
              return LoadAssetImage(
                _guideList[index],
                key: Key(_guideList[index]),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
            onTap: (index) {
              if (index == _guideList.length - 1) {
                _goLogin();
              }
            },
          );
        }
        break;
      default:
        {}
        break;

    }
  }
}
