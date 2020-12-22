
import 'package:demo/tools/res/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../public_header.dart';
import 'dialog/default_bottom_sheet.dart';
import 'dialog/edit_dialog.dart';
import 'dialog/exit_dialog.dart';
import 'net/UploadUtils.dart';



class AppShowBottomDialog {

  ///更换头像
  static showPhotoBottom(BuildContext context, Function result) {
    showModalBottomSheet(
      context: context,

      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DefaultBottomSheet(
            title1: '相机',
            title2: '相册',
            onPress1: () {
              Permission.camera.request().then((value) async {
                if (value.isGranted) {
                  PickedFile pickedFile =
                      await ImagePicker().getImage(source: ImageSource.camera);
                  if (pickedFile != null && pickedFile.path != null) {
                    //todo 上传图片
                    String url = await UploadUtils.uploadImage2(pickedFile.path);
                    if ((url ?? "").isNotEmpty) {
                      result(url);
                    } else {
                      result('');
                    }
                  }
                } else {
                  Toast.show('相机权限被拒绝,请到设置页面打开');
                }
              });
            },
            onPress2: () {
              Permission.photos.request().then((value) async {
                if (value.isGranted) {
                  PickedFile pickedFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  if (pickedFile != null && pickedFile.path != null) {
                    //todo 上传图片
                    String url =
                        await UploadUtils.uploadImage2(pickedFile.path);
                    if ((url ?? "").isNotEmpty) {
                      result(url);
                    }
                  }
                } else {
                  Toast.show('相册权限被拒绝,请到设置页面打开');
                }
              });
            });
      },
    );
  }

  ///拨打电话
  static showCallPhoneDialog(String phone, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Text('是否拨打：$phone ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => AppPush.goBack(context),
                child: const Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  Utils.launchTelURL(phone);
                  AppPush.goBack(context);
                },
                textColor: Theme.of(context).errorColor,
                child: const Text('拨打'),
              ),
            ],
          );
        });
  }

  ///弹窗编辑onPress
  static showEdit(String title, Function onPress, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return EditDialog(
            title: title,
            onPressed: (value){
              onPress(value);
            },
          );
        });
  }

  ///退出登录
  static showExit(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ExitDialog();
        });
  }


}
