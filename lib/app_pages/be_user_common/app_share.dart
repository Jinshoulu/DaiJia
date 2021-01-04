
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluwx/fluwx.dart';


import '../../public_header.dart';

class AppShare {

  getData(String type, data, BuildContext context){
    print('分享类型 = = $data');
    var requestData = data;
    switch(type){
      case 'QQ':{
        requestData['mode'] = 'friend ';
      }break;
      case 'friend':{
        requestData['mode'] = 'link ';
      }break;
      case 'session':{
        requestData['mode'] = 'link ';
      }break;
      case 'msg':{
        requestData['mode'] = 'link ';
      }break;
      default:{
        requestData['mode'] = 'link';
      }break;
    }
    DioUtils.instance.post(Api.registerUrl ,data: requestData, onFailure: (code,msg){},onSucceed: (response){
      Navigator.pop(context);
      var shareData = response;
      switch(type){
        case 'sesion':{
          wxMiniProgram(shareData);
        }break;
        case 'friend':{
          wxShareWeb(shareData, WeChatScene.TIMELINE);
        }break;
        default:{
          Toast.show('已复制到粘贴板');
          Clipboard.setData(ClipboardData(text: shareData['url']??''));
        }break;
      }
    });
  }

  //分享网址到微信
  wxShareWeb(data, WeChatScene scene) {
    //   [WeChatScene.SESSION]会话
    //   [WeChatScene.TIMELINE]朋友圈
    //   [WeChatScene.FAVORITE]收藏
    shareToWeChat(WeChatShareWebPageModel(
      data['url'] ?? '',
      title: data['title'] ?? '',
      description: data['desc'] ?? '',
      thumbnail: WeChatImage.network(data['img'] ?? ''),
      scene: scene,
    ));
  }

  //分享图片到微信
  wxShareImage({String imageUrl, WeChatScene scene: WeChatScene.TIMELINE}) {
    //WeChatScene.SESSION,会话
    //WeChatScene.TIMELINE,朋友圈
    //WeChatScene.FAVORITE,收藏
    // var thumbnail = WeChatImage.asset(
    //   "images/font_go_with_tsd.png",
    // );
    print("分享图片地址：" + imageUrl);
    var source = WeChatImage.network(
        imageUrl); //"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3844276591,3933131866&fm=26&gp=0.jpg"
    var model = WeChatShareImageModel(source, thumbnail: source, scene: scene);
    shareToWeChat(model);
  }

  //拉起微信小程序
  wxMiniProgram(var shareData) {
    //     "share": {    //分享好友需要带的参数。
    // "liveid": "5bCP5bCP5Li75pKtIyMjMTUwOTMxMTM0NTQjIyMxXzU%3D",
    // "userid": "5bCP6YeRIyMjMTU1NjAyNzAxMjA%3D"
    // "live_user_id" : 101  //直播间ID
    // "wxid": "gh_07dd1b9fc1fb",   //原始ID
    // "cover_img": "http://imgs.sbyssh.com/FnqKns_atofspMnBVE2gnqTBqchj",  //图片
    // "live_des": "xiaoxiaozhubo正在直播，快来观看吧！", // 标题
    // "live_title": "新版直播测试",  //描述
    // "url": "https://subangapp.7oks.com",   ///域名
    // "path": "moduleA/pages/player/player"  //小程序页面
    // },
    print(shareData['type']);

    WXMiniProgramType programType;
    int type = shareData['type']??0;
    switch(type){
      case 1:{
        programType = WXMiniProgramType.TEST;
      }break;
      case 2:{
        programType = WXMiniProgramType.PREVIEW;
      }break;
      default:{
        programType = WXMiniProgramType.RELEASE;
      }break;
    }

    var model = new WeChatShareMiniProgramModel(
      path: "${shareData['path']??''}",
      webPageUrl: "${shareData['url']??''}",
      userName: "${shareData['ghid']??''}",
      //原始id 小程序的 看好 原始id 不是appid
      title: "${shareData['title']??''}",
      description: "${shareData['description']??''}",
      thumbnail: WeChatImage.network("${shareData['img']??''}",),
      miniProgramType: programType
    );
    shareToWeChat(model);
    // launchWeChatMiniProgram(username: "gh_d43f693ca31f",miniProgramType: );
  }


}