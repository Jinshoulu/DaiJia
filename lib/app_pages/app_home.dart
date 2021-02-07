
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:demo/app_pages/be_user_common/AppLocal.dart';
import 'package:demo/app_pages/be_user_common/AppPlayAudio.dart';
import 'package:demo/app_pages/driver/Driver.dart';
import 'package:demo/app_pages/mine/Mine.dart';
import 'package:demo/app_pages/order/Order.dart';
import 'package:demo/app_pages/workbench/workbench.dart';
import 'package:demo/provider/app_status.dart';
import 'package:demo/provider/user_info.dart';
import 'package:demo/z_tools/add/double_tap_back_exit_app.dart';
import 'package:demo/z_tools/app_bus_event.dart';
import 'package:demo/z_tools/dialog/update_dialog.dart';
import 'package:demo/z_tools/image/FrameAnimImage.dart';
import 'package:demo/z_tools/save_data.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../public_header.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {

  ///链接状态
  bool isLinkInternet = true;
  PageController _pageController = PageController();
  //默认选择下标
  int mSelected = 0;
  double btnWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    btnWidth = 120.0;

    SpUtil.putBool(AppValue.login_state, true);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initLoad();
    });

    eventBus.on().listen((event) {
      ///音频播放
      if(event is PlayerAudio){
        //'audio/message.mp3'
        AppPlayAudio.instance.play(event.audioName);
      }
      if(event is ExitApp){
        AppClass.exitApp(this.context);
      }
    });
    if(SpUtil.getBool(SaveData.smartUpdate,defValue: true)){
      UpdateApp.determineAppVersion(this.context, true);
    }
  }

  ///
  initLoad()async{
    await Provider.of<AppStatus>(this.context,listen: false).init();
    await Provider.of<UserInfo>(this.context,listen: false).getUserInfo();
    await initConnectivity();
    await  AppLocal.getLocation(this.context).then((value){
      print(value);
    });
    startTime();
  }

  ///提交自己的位置
  Timer _timer;
  List dataList = [];
  int count = 0;
  int allCount = 0;
  List uploadFailedAddress = [];
  ///加载定时器
  startTime(){
    if(_timer==null){
      _timer = Timer.periodic(Duration(seconds: 6), (time){
        print('--------> $count');
          AppLocal.reloadLocation(this.context).then((value){
            var data = {
              'location':'${SpUtil.getString(AppValue.user_local_long)},${SpUtil.getString(AppValue.user_local_late)}',
              'locatetime':DateTime.now().millisecondsSinceEpoch
            };
            dataList.add(data);
          });
          count++;
          if(count==10){
            allCount = allCount+10;
            print('--------> $allCount');
            count=0;
            subLocalData();
            subCurrentAddressData();
          }
      });
    }
  }

  ///提交代驾轨迹到高德服务器
  subLocalData(){

    if(dataList.length==0){
      debugPrint('上传的轨迹是空的');
      return;
    }
    var data = {
      'points':json.encode(dataList),
      'key':SpUtil.getString(AppValue.user_key),
      'sid':SpUtil.getString(AppValue.user_sid),
      'tid':SpUtil.getString(AppValue.user_tid),
      'trid':SpUtil.getString(AppValue.user_trid)
    };
    DioUtils.instance.post(Api.uploadPointUrl,data: data,onSucceed: (response){
      dataList.clear();
    },onFailure: (code,msg){
      dataList.clear();
      AppClass.saveCurrentAddressData(data);
    });
  }

  ///提交新位置到服务器
  subCurrentAddressData(){

    var data = {
      'province_id':SpUtil.getString(AppValue.user_province_id),
      'city_id':SpUtil.getString(AppValue.user_city_id),
      'area_id':SpUtil.getString(AppValue.user_area_id),
      'lon':SpUtil.getString(AppValue.user_local_long),
      'lat':SpUtil.getString(AppValue.user_local_late),
      'address':SpUtil.getString(AppValue.user_local_address)
    };
    DioUtils.instance.post(Api.uploadCurrentPointUrl,data: data,onSucceed: (response){

    },onFailure: (code,msg){

    });
  }
  ///提交失败的位置信息
  submitFailedAddress(){
    if(!mounted){
      return;
    }
    if(uploadFailedAddress.length==0){
      return;
    }else{
      var data = uploadFailedAddress.first;
      if(data['key']==null){
        data['key'] = Provider.of<UserInfo>(this.context,listen: false).key;
        data['sid'] = Provider.of<UserInfo>(this.context,listen: false).sid;
        data['tid'] = Provider.of<UserInfo>(this.context,listen: false).tid;
        data['trid'] = Provider.of<UserInfo>(this.context,listen: false).trid;
      }
      DioUtils.instance.post(Api.uploadPointUrl,data: data,onSucceed: (response){
        uploadFailedAddress.removeAt(0);
        submitFailedAddress();
      },onFailure: (code,msg){
        AppClass.saveCurrentAddressData(data);
      });
    };

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
        case ConnectivityResult.mobile:
          Provider.of<AppStatus>(this.context,listen: false).connect = true;
          if (mounted) {
            setState(() {
              isLinkInternet = true;
            });
          }
          AppClass.getUploadSaveAddress().then((value){
            if(value.isNotEmpty||value.length!=0){
              submitFailedAddress();
            }
          });
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    _timer = null;
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


}
