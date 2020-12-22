
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../public_header.dart';

class OperateDoneDialog extends StatefulWidget {

  final String image;
  final String content;
  final String cancelText;
  final String sureText;
  final List downloadImage;
  final bool isHiddenCancel;
  final Function surePress;
  final double width;

  const OperateDoneDialog({
    Key key,
    this.image ='images/成功',
    this.sureText = '确定完成',
    this.surePress,
    this.content='确定本次开锁服务完成',
    this.cancelText = '取消',
    this.isHiddenCancel = false,
    this.width = 280.0,
    this.downloadImage
  }) : super(key: key);


  @override
  _OperateDoneDialogState createState() => _OperateDoneDialogState();
}

class _OperateDoneDialogState extends State<OperateDoneDialog> {


  String downloadProgress = '0%';
  int imageCount = 1;
  List downloadImages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadImages.addAll(widget.downloadImage);
    if(downloadImages!=null){
      imageCount = widget.downloadImage.length;
      startDownloadImage(downloadImages);
    }
  }
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                color: ThemeUtils.getDialogBackgroundColor(context),
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: widget.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: widget.width,
                    child: Center(
                        child: LoadAssetImage(widget.image,height: 50,width: 50,)
                    ),
                  ),
                  imageCount>1?Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text('剩余下载：$imageCount'),
                  ):SizedBox(),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                      child: Text(widget.downloadImage==null?widget.content:downloadProgress, style: TextStyles.blackAnd14)
                  ),
                  Gaps.vGap10,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0 , top: 5.0),
                    child: Row(
                      mainAxisAlignment: widget.isHiddenCancel?MainAxisAlignment.center:MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        widget.isHiddenCancel?SizedBox():Container(
                          width: 110.0,
                          height: 36.0,
                          child: FlatButton(
                            onPressed: () {
                              AppPush.goBack(context);
                            },
                            textColor: AppColors.black87Color,
                            color: AppColors.inputBgColor,
                            disabledTextColor: Colors.white,
                            disabledColor: AppColors.text_gray_c,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: AppColors.inputBgColor,
                                  width: 0.8,
                                )
                            ),
                            child: Text(
                              widget.cancelText,
                              style: TextStyle(fontSize: Dimens.font_sp14),
                            ),
                          ),
                        ),
                        Container(
                          width: 110.0,
                          height: 36.0,
                          child: FlatButton(
                            onPressed: () {
                              AppPush.goBack(context);
                              widget.surePress();
                            },
                            textColor: Colors.white,
                            color: primaryColor,
                            disabledTextColor: Colors.white,
                            disabledColor: AppColors.text_gray_c,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              widget.sureText,
                              style: TextStyle(fontSize: Dimens.font_sp14),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        )
    );
  }

  startDownloadImage(List images)async{
    setState(() {
      imageCount = images.length;
    });
    if(images.length>0){
      startDownloadOneImage(images);
    }
  }

  startDownloadOneImage(List images)async{
    var response = await Dio().get(
        images.first,
        options: Options(responseType: ResponseType.bytes),onReceiveProgress: (value, value2){
      print(value/value2);
      setState(() {
        downloadProgress = ((value/value2)*100).toStringAsFixed(2)+'%';
      });
    });
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: DateTime.now().toString()
    );
    print('保存到本地相册 = result = $result');
    images.removeAt(0);
    startDownloadImage(images);

  }
}
