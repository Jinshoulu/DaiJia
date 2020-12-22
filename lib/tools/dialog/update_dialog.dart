
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

import '../../public_header.dart';


class UpdateApp{
  
  static determineAppVersion (BuildContext context)async{

    //获取当前版本
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String localVersion = packageInfo.version.replaceAll(".", "");
    print('current version = ------> $localVersion');
    DioUtils.instance.post(Api.getVersionInfoUrl, onFailure: (code, msg) {}, onSucceed: (result) {
      UpdateBean updateInfo = UpdateBean.fromJson(result['data']);
      int l = int.parse(localVersion);
      int s = int.parse(updateInfo.version_no.replaceAll(".", ""));
      debugPrint("当前版本：" + l.toString());
      debugPrint("服务器版本：" + s.toString());
      if(l<s){
        //强更新
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext bc) {
            return new UpdateDialog(
              title: "检测到新版本,正在更新中 ···",
              version: updateInfo?.version_no,
              url: updateInfo?.android_files,
            );
          },
        );
//        showDialog(context: context, builder: (BuildContext bc){
//          return new OperateDialog(
//            title: '版本更新',
//            sureText: '马上更新',
//            cancelText: '取消更新',
//            content: "${updateInfo.upgrade_notes}",
//            surePress: (String content){
//              Navigator.pop(context);
//              showDialog(
//                context: context,
//                barrierDismissible: false,
//                builder: (BuildContext bc) {
//                  return new UpdateDialog(
//                    title: "更新中 ···",
//                    version: updateInfo?.version_no,
//                    url: updateInfo?.android_files,
//                  );
////                  return new SizedBox();
//                },
//              );
//            },
//          );
//        });
      }
    });
    
  }
  
}

class UpdateBean {
    String android_file;
    String android_files;
    String ios_url;
    String upgrade_notes;
    String version_ios;
    String version_no;

    UpdateBean({this.android_file, this.android_files, this.ios_url, this.upgrade_notes, this.version_ios, this.version_no});

    factory UpdateBean.fromJson(Map<String, dynamic> json) {
        return UpdateBean(
            android_file: json['android_file'], 
            android_files: json['android_files'], 
            ios_url: json['ios_url'], 
            upgrade_notes: json['upgrade_notes'], 
            version_ios: json['version_ios'], 
            version_no: json['version_no'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['android_file'] = this.android_file;
        data['android_files'] = this.android_files;
        data['ios_url'] = this.ios_url;
        data['upgrade_notes'] = this.upgrade_notes;
        data['version_ios'] = this.version_ios;
        data['version_no'] = this.version_no;
        return data;
    }
}
/*
showDialog(context: context, builder: (BuildContext bc) {
return new AstgoWarmDialog();
},);
*/
class UpdateDialog extends StatefulWidget {
  final String title;
  final String version;
  final String url;

  const UpdateDialog({Key key, this.title, this.version, this.url})
      : super(key: key);

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  //下载进度
  String progress = "0%";

  String taskId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //创建透明层
          backgroundColor: Color(0x00000000),
          // 键盘弹出收起动画过渡
          body: AnimatedContainer(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewInsets.bottom,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeInCubic,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(8),
                ),
                width: 270,
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: new Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: new Text("${widget?.title ?? "更新中···"}"),
                      ),
                    ),
                    Flexible(
                      child: new Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: new Text("$progress"),
                      ),
                    ),
                    SizedBox(height: 16),
//                    SizedBox(
//                      height: 1,
//                      width: double.infinity,
//                      child: const DecoratedBox(
//                          decoration: BoxDecoration(color: Color(0xFFEEEEEE))),
//                    ),
                  ],
                )),
          ),
        ),
        onWillPop: () {
          return Future.value(false);
        });
  }

  /// 安装
  Future<Null> _installApk(String filePath) async {
    Navigator.pop(context);
    try {
      InstallPlugin.installApk(filePath, 'com.astgo.app.orders')
          .then((result) {
        debugPrint('install apk $result');
      }).catchError((error) {
        debugPrint('install apk error: $error');
      });
    } on PlatformException catch (_) {}
  }

  Future download() async {
    //获取根目录地址
    final dir = await getExternalStorageDirectory();
    //自定义目录路径(可多级)
    String filePath = dir.path + '/apk.apk';
    Dio dio = new Dio();
    try {
      Response response = await dio.download(
        widget?.url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            this.progress = (received / total * 100).toStringAsFixed(0) + "%";
            print("文件下载1：" + progress);
            setState(() {});

            if (received == total) {
              _installApk(filePath);
            }
          }
        },
      );
    } catch (e) {
      Toast.show("更新失败！");
      Navigator.pop(context);
    }

  }
}
