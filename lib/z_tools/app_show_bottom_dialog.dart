
import 'package:demo/app_pages/order/dialog/OrderDetailDialog.dart';
import 'package:demo/app_pages/order/dialog/QRImageDialog.dart';
import 'package:demo/app_pages/workbench/tools/home_send_order_dialog.dart';
import 'package:demo/app_pages/workbench/tools/share_menu_dialog.dart';
import 'package:demo/app_pages/workbench/tools/show_reload_local_dialog.dart';
import 'package:demo/z_tools/app_widget/AppBoldText.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/dialog/empty_bottom_sheet.dart';
import 'package:demo/z_tools/dialog/list_bottom_sheet.dart';
import 'package:demo/z_tools/dialog/operate_empty_dialog.dart';
import 'package:demo/z_tools/dialog/operate_mode2_dialog.dart';
import 'package:demo/z_tools/res/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../public_header.dart';
import 'dialog/default_bottom_sheet.dart';
import 'dialog/edit_dialog.dart';
import 'dialog/exit_dialog.dart';
import 'dialog/operate_done_dialog.dart';
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

  ///发现，图片保存本地
  static showFoundSaveDone(BuildContext context, var data, Function onPress) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => OperateDoneDialog(
          image: '保存完成',
          width: 200,
          downloadImage: data,
          content: '保存成功',
          sureText: '确定',
          isHiddenCancel: true,
          surePress: () {
            onPress();
          },
        ));
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

  ///正常的弹窗
  static showNormalDialog(BuildContext context,String cancelText,String sureText, String title, String content, Function onPress) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return OperateMode2Dialog(surePress: () {
            onPress();
          },title: title,content: content,sureText: sureText,cancelText: cancelText,);
        });
  }

  ///派单的弹窗
  static showSendOrder(BuildContext context, String title, String btnTitle,
      Widget centerWidget, Function onPress) {

    showModalBottomSheet(
        context: context,
        /// 使用true则高度不受16分之9的最高限制
        isScrollControlled: true,
        builder: (BuildContext context) {
          return HomeSendOrderDialog(
            centerWidget: centerWidget,
            title: title,
            btnTitle: btnTitle,
            btnPress: () {
              onPress();
            },
          );
        }
    );

  }

  ///字符串列表弹窗
  static showBottomListSheet(BuildContext context, String title, List list,Function onPress) {

    showModalBottomSheet(
        context: context,
        /// 使用true则高度不受16分之9的最高限制
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ListBottomSheet(
              title: title,
              tips: list,
              onTapDelete: (value){
                onPress(value);
              }
          );
        }
    );

  }

  ///刷新当前位置弹窗
  static showReloadLocal(BuildContext context, String address) {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ShowReloadLocalDialog(
            content: address,
          );
        });

  }

  ///分享
  static showShare(BuildContext context) {

    showModalBottomSheet(
        context: context,
        /// 使用true则高度不受16分之9的最高限制
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ShareMenuDialog();
        }
    );

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

  ///中间协议
  static showDelegateDialog(BuildContext context, String title, String content, Function onPress) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return OperateEmptyDialog(
              topWidget: TextContainer(title: title, height: 40, style: TextStyle(fontSize: Dimens.font_sp16,color: AppColors.mainColor)),
              centerWidget: Container(
                height: 250.0,
                padding: EdgeInsets.all(16),
                child: Html(data: content),
              ),
              bottomWidget: Container(
                height: 45,
                child: Expanded(child: AppButton(title: '同意并了解',bgColor: AppColors.mainColor, textStyle: TextStyles.whiteAnd14,onPress: () {
                  Navigator.pop(context);
                  onPress();
                })),
              )
          );
        });
  }

  ///底部协议
  static showDelegateSheetDialog(BuildContext context, String title, String content,String sureText, Function onPress) {
    showModalBottomSheet(
        context: context,
        /// 使用true则高度不受16分之9的最高限制
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return EmptyBottomSheet(
              edgeInsets: EdgeInsets.only(bottom: 30.0),
              topWidget: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(child: AppBoldText(text: title,fonSize: 18,)),
                    Positioned(left: 0,right: 0,bottom: 0,child: Container(color: AppColors.bgColor,height: 1,)),
                  ],
                ),
              ),
              centerWidget: Container(
                padding: EdgeInsets.all(16),
                height: 300.0,
                child: Html(data: content),
              ),
              downWidget: Container(
                height: 45,
                width: double.infinity,
                padding: EdgeInsets.only(left: 16,right: 16),
                child: SizedBox(
                  child: AppButton(radius: 45.0,title: sureText.isEmpty?'我知道了':sureText,bgColor: AppColors.mainColor, textStyle: TextStyles.whiteAnd14,onPress: () {
                    Navigator.pop(context);
                    onPress();
                  }),
                ),
              )
          );
        }
    );
  }

  ///中间是空的
  static showEmptyCenterSheetDialog(BuildContext context, String title,Widget topRightWidget, Widget centerWidget, String sureText, Function onPress) {
    showModalBottomSheet(
        context: context,
        /// 使用true则高度不受16分之9的最高限制
        isScrollControlled: true,
        builder: (BuildContext context) {
          return EmptyBottomSheet(
              edgeInsets: EdgeInsets.only(bottom: 30.0),
              topWidget: Container(
                height: 60.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(child: TextContainer(
                        alignment: Alignment.center,
                        showBottomSlide: true,
                        slideColor: AppColors.black54Color,
                        title: title,
                        height: 60,
                        style: TextStyle(fontSize: 18,color: AppColors.blackColor))),
                    Positioned(child: topRightWidget??SizedBox(),top: 0,right: 0,bottom: 0,)
                  ],
                )
              ),
              centerWidget: centerWidget??Container(),
              downWidget: Container(
                height: 75.0,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(left: 16,right: 16),
                child: SizedBox(
                  height: 45.0,
                  child: AppButton(radius: 45.0,title: sureText.isEmpty?'确定':sureText,bgColor: AppColors.mainColor, textStyle: TextStyles.whiteAnd14,onPress: () {
                    Navigator.pop(context);
                    onPress();
                  }),
                ),
              )
          );
        }
    );
  }

  ///中间是空的
  static showSheetQRImageDialog(BuildContext context, Function onPress) {
    showModalBottomSheet(
        context: context,
        /// 使用true则高度不受16分之9的最高限制
        isScrollControlled: true,
        builder: (BuildContext context) {
          return QRImageDialog(
            onPress: (int index){
              onPress(index);
            },
          );
        }
    );
  }

  ///查看订单详情
  static showOrderDetailDialog(BuildContext context, var data) {
    showModalBottomSheet(
        context: context,
        /// 使用true则高度不受16分之9的最高限制
        isScrollControlled: true,
        builder: (BuildContext context) {
            return OrderDetailDialog(
              data: data,
            );
        }
    );
  }
}
