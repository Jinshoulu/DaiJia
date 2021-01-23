
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:demo/app_pages/be_user_common/AppLocal.dart';
import 'package:demo/app_pages/driver/Driver.dart';
import 'package:demo/app_pages/mine/Mine.dart';
import 'package:demo/app_pages/order/Order.dart';
import 'package:demo/app_pages/workbench/workbench.dart';
import 'package:demo/provider/app_status.dart';
import 'package:demo/z_tools/add/double_tap_back_exit_app.dart';
import 'package:demo/z_tools/app_bus_event.dart';
import 'package:demo/z_tools/image/FrameAnimImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../public_header.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {

  ///链接状态
  bool isLinkInternet = false;
  PageController _pageController = PageController();
  //默认选择下标
  int mSelected = 0;
  double btnWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    btnWidth = 120.0;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initLoad();
    });

    eventBus.on().listen((event) {
      ///音频播放
      if(event is PlayerAudio){
        playAudio(event.audioName);
      }
    });
  }

  initLoad()async{
    await Provider.of<AppStatus>(context,listen: false).init();
    await initConnectivity();
    await  AppLocal.getLocation().then((value){
      print(value);
    });
    ///初始化音频
    initAudioPlayer();
  }

  ///添加网络监听
  initConnectivity() async {

    ConnectivityResult result;
    Connectivity _connectivity = Connectivity();
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
    }
    _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      switch (result) {
        case ConnectivityResult.wifi:
          print('当前使用的是wifi网络');
          Provider.of<AppStatus>(this.context,listen: false).connect = true;
          if (mounted) {
            setState(() {
              isLinkInternet = true;
            });
          }
          break;
        case ConnectivityResult.mobile:
          print('当前使用的是手机网络');
          Provider.of<AppStatus>(this.context,listen: false).connect = true;
          if (mounted) {
            setState(() {
              isLinkInternet = true;
            });
          }
          break;
        case ConnectivityResult.none:
          print('当前无可用网络');
          Provider.of<AppStatus>(this.context,listen: false).connect = false;
          if (mounted) {
            setState(() {
              isLinkInternet = false;
            });
          }
          break;
        default:
          print('获取网络状态失败');
          Provider.of<AppStatus>(this.context,listen: false).connect = false;
          if (mounted) {
            setState(() {
              isLinkInternet = false;
            });
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                  child: new PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index){
                      debugPrint("当前索引：" + index.toString());
                      mSelected = index;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    children: <Widget>[
                      new Workbench(),
                      new Order(),
                      new Driver(),
                      new Mine()
                    ],
                  )
              )
            ],
          ),
          bottomNavigationBar: new Container(
            height: 50,
            width: double.infinity,
            margin: (MediaQuery.of(context).padding.bottom > 0 && Platform.isIOS)
                ? EdgeInsets.only(bottom: 16)
                : EdgeInsets.only(bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.black12Color,width: 1))
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                createAnimatedContainer(0, 'images/工作台默认.png', 'images/工作台触发.png', ' 工作台',),
                createAnimatedContainer(1, 'images/订单默认.png', 'images/订单触发.png', ' 订单',),
                createAnimatedContainer(2, 'images/司机默认.png', 'images/司机触发.png', ' 司机',),
                createAnimatedContainer(3, 'images/个人中心默认.png', 'images/个人中心触发.png', ' 个人中心',),
              ],
            ),
          ),
        ),
    );
  }

  ///标签按钮
  createAnimatedContainer(int selectIndex,String normalImage,String selectImage,String title){

    return Expanded(
      child: AnimatedContainer(
        width: mSelected == selectIndex ? btnWidth : 50,
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: mSelected == selectIndex
              ? Theme.of(context).primaryColor.withOpacity(1.0)
              : Theme.of(context)
              .scaffoldBackgroundColor
              .withOpacity(0.0),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            _pageController?.jumpToPage(selectIndex);
          },
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                mSelected == selectIndex
                    ? FrameAnimImage(
                  key: new GlobalKey(debugLabel: selectIndex.toString()),
                  imagePaths: [
                    normalImage,
                  ],
                  defaultImage: selectImage,
                  interval: 80,
                )
                    : new Image.asset(
                  selectImage,
                  width: 22,
                  height: 22,
                ),
                mSelected == selectIndex
                    ? new Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 12,
                  ),
                )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // **************** 音频播放 *************
  AudioPlayer _audioPlayer;
  AudioCache _audioCache;
  AudioPlayerState _AudioPlayerState = AudioPlayerState.STOPPED;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;
  StreamSubscription  mStreamSubscription;

  initAudioPlayer(){

    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    if (Platform.isIOS) {
      if (_audioCache.fixedPlayer != null) {
        _audioCache.fixedPlayer.startHeadlessService();
      }
      _audioPlayer.startHeadlessService();
    }
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      // TODO implemented for iOS, waiting for android impl
      if (Platform.isIOS) {
        // (Optional) listen for notification updates in the background
        _audioPlayer.startHeadlessService();
      }
    });

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p){
          debugPrint('audioPlayer onAudioPositionChanged $p');
        });

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
          debugPrint('audioPlayer onPlayerCompletion ');
          _audioPlayer.stop();
          _AudioPlayerState = AudioPlayerState.STOPPED;
        });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      debugPrint('audioPlayer error : $msg');
      _AudioPlayerState = AudioPlayerState.STOPPED;
      _audioPlayer.stop();
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      debugPrint('audioPlayer onPlayerStateChanged $state');
      _AudioPlayerState = state;
    });
    _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      debugPrint('audioPlayer onNotificationPlayerStateChanged $state');
    });

    _audioPlayer.play('assets/audio/message.mp3');
  }

  ///销毁播放器
  disAudioPlayer()async {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    await _audioPlayer.release();
    debugPrint('收到关闭语音的消息了3');
    _audioPlayer.dispose();
  }

  ///使用播放器播放
  playAudio(String url) async {

    if(_AudioPlayerState==AudioPlayerState.PLAYING){
      debugPrint('有音频正在播放');
      return;
    }
    if (url == null || url.isEmpty) {
      return;
    }
    debugPrint("音频路径：${url + "-------------------"} \n 保存的路径 = $url");

    if(url.contains('http')){
      await _audioPlayer.setUrl(url);
    }else{
      await _audioPlayer.setUrl(url);
    }
//    int result = await _audioPlayer.earpieceOrSpeakersToggle();
//    debugPrint("当前模式后： $result");
//
//    _audioPlayer.setPlaybackRate(playbackRate: 1.0);

  }

  ///播放器暂停
  Future<int> audioPause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) {}
    return result;
  }

  ///设置外音
  setPlayState() async {
    //  "status5": "2",//使用听筒播放语音：1开启2关闭，默认为2
    int result = await _audioPlayer.earpieceOrSpeakersToggle();
    debugPrint("当前模式后： $result");
  }
}
