

import 'package:demo/app_pages/be_user_common/app_share.dart';
import 'package:flutter/material.dart';
import '../../../public_header.dart';

class ShareMenuDialog extends StatefulWidget {


  @override
  _ShareMenuDialogState createState() => _ShareMenuDialogState();
}

class _ShareMenuDialogState extends State<ShareMenuDialog> {

  List list = [{'title':'QQ','image':'QQ'},{'title':'微信好友','image':'微信'},{'title':'朋友圈','image':'朋友圈'},{'title':'复制链接','image':'短信'}];

  var shareData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 20,left: 16,right: 16,bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
            color: AppColors.whiteColor
        ),
        height: 250.0,
        /// 为保留状态，选择ChangeNotifierProvider.value，销毁自己手动处理（见 goods_edit_page.dart ：dispose()）
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 52.0,
              child: Center(
                child: Text(
                  '请选择分享平台',
                  style: TextStyle(fontSize: Dimens.font_sp14,color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 0.6,
              width: double.infinity,
              child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.black54Color)),
            ),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    createMenuItem(0, (){
                      AppShare().getData('QQ', shareData, context);
                    }),
                    createMenuItem(1, (){
                      AppShare().getData('friend', shareData, context);
                    }),
                    createMenuItem(2, (){
                      AppShare().getData('session', shareData, context);
                    }),
                    createMenuItem(3, (){
                      AppShare().getData('msg', shareData, context);
                    }),

                  ],
                )
            ),
            Container(
              padding: EdgeInsets.only(left: 16,right: 16),
              height: 50.0,
              alignment: Alignment.center,
              child: AppButton(title: '取消分享',textStyle: TextStyle(fontSize: 14,color: ColorsApp.whiteColor), onPress: (){
                Navigator.pop(context);
              }),
            )
          ],
        ),
      ),
    );
  }

  createMenuItem(int index,Function onPress){
    Map data = list[index];
    return Expanded(
        child: InkWell(
          onTap: (){
            onPress();
          },
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LoadAssetImage(data['image'],width: 50.0,height: 50.0,fit: BoxFit.fill,),
                Gaps.vGap10,
                Text(data['title'],style: TextStyles.blackAnd14,)
              ],
            ),
          ),
        )
    );
  }

//  //分享网址到微信
//  wxShareWeb(data, WeChatScene scene) {
//    //   [WeChatScene.SESSION]会话
//    //   [WeChatScene.TIMELINE]朋友圈
//    //   [WeChatScene.FAVORITE]收藏
//    shareToWeChat(WeChatShareWebPageModel(
//      data['url'] ?? '',
//      title: data['title'] ?? '',
//      description: data['desc'] ?? '',
//      thumbnail: WeChatImage.network(data['img'] ?? ''),
//      scene: scene,
//    ));
//  }
//
//  //分享图片到微信
//  wxShareImage({String imageUrl, WeChatScene scene: WeChatScene.TIMELINE}) {
//    //WeChatScene.SESSION,会话
//    //WeChatScene.TIMELINE,朋友圈
//    //WeChatScene.FAVORITE,收藏
//    // var thumbnail = WeChatImage.asset(
//    //   "images/font_go_with_tsd.png",
//    // );
//    print("分享图片地址：" + imageUrl);
//    var source = WeChatImage.network(
//        imageUrl); //"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3844276591,3933131866&fm=26&gp=0.jpg"
//    var model = WeChatShareImageModel(source, thumbnail: source, scene: scene);
//    shareToWeChat(model);
//  }
//
//  //拉起微信小程序
//  wxMiniProgram(var shareData) {
//    //     "share": {    //分享好友需要带的参数。
//    // "liveid": "5bCP5bCP5Li75pKtIyMjMTUwOTMxMTM0NTQjIyMxXzU%3D",
//    // "userid": "5bCP6YeRIyMjMTU1NjAyNzAxMjA%3D"
//    // "live_user_id" : 101  //直播间ID
//    // "wxid": "gh_07dd1b9fc1fb",   //原始ID
//    // "cover_img": "http://imgs.sbyssh.com/FnqKns_atofspMnBVE2gnqTBqchj",  //图片
//    // "live_des": "xiaoxiaozhubo正在直播，快来观看吧！", // 标题
//    // "live_title": "新版直播测试",  //描述
//    // "url": "https://subangapp.7oks.com",   ///域名
//    // "path": "moduleA/pages/player/player"  //小程序页面
//    // },
//    var model = new WeChatShareMiniProgramModel(
//      path: "${shareData['path']??''}",
//      webPageUrl: "${shareData['url']??''}",
//      userName: "${shareData['ghid']??''}",
//      //原始id 小程序的 看好 原始id 不是appid
//      title: "${shareData['title']??''}",
//      description: "${shareData['description']??''}",
//      thumbnail: WeChatImage.network("${shareData['img']??''}",),
//    );
//    shareToWeChat(model);
//    // launchWeChatMiniProgram(username: "gh_d43f693ca31f",miniProgramType: );
//  }


}
