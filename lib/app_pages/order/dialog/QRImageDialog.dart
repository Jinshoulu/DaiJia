
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QRImageDialog extends StatefulWidget {

  final Function onPress;

  const QRImageDialog({Key key,@required this.onPress}) : super(key: key);


  @override
  _QRImageDialogState createState() => _QRImageDialogState();
}

class _QRImageDialogState extends State<QRImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: AppColors.mainColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 40.0,),
              Container(
                height: 400,
                margin: EdgeInsets.only(left: 16,right: 16),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SizedBox(
                        height: 45.0,
                        child: AppButton(
                            mainAxisAlignment: MainAxisAlignment.start,
                            title: '收款',
                            textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                            image: '订单-收款',
                            imageSize: 20,
                            buttonType: ButtonType.leftImage, onPress: (){}),
                      ),
                    ),
                    AppSizeBox(height: 1,),
                    SizedBox(height: 20,),
                    Expanded(
                        child: Container(alignment: Alignment.center,child: LoadImage('',radius: 0.0,))
                    ),
                    TextContainer(
                        alignment: Alignment.center,
                        title: '费用合计:50元', height: 50.0, style: TextStyle(fontSize: 14.0,color: AppColors.red)),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              SizedBox(height: 40.0,),
              Container(
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AppButton(
                          title: '紧急求助',
                          image: '订单-紧急求助',
                          imageColor: AppColors.whiteColor,
                          imageSize: 20.0,
                          disW: 0,
                          textStyle: TextStyle(fontSize: 12,color: AppColors.whiteColor),
                          buttonType: ButtonType.upImage,
                          onPress: () {
                            widget.onPress(0);
                          }),
                    ),
                    AppSizeBox(
                      width: 1,
                      color: AppColors.whiteColor,
                      height: 30.0,
                    ),
                    Expanded(
                      child: AppButton(
                          title: '事故处理',
                          image: '订单-事故处理',
                          imageColor: AppColors.whiteColor,
                          imageSize: 20.0,
                          disW: 0,
                          textStyle: TextStyle(fontSize: 12,color: AppColors.whiteColor),
                          buttonType: ButtonType.upImage,
                          onPress: () {
                            widget.onPress(1);
                          }),
                    ),
                    AppSizeBox(
                      width: 1,
                      color: AppColors.whiteColor,
                      height: 30.0,
                    ),
                    Expanded(
                      child: AppButton(
                          title: '联系客服',
                          image: '订单-客服',
                          imageColor: AppColors.whiteColor,
                          imageSize: 20.0,
                          disW: 0,
                          textStyle: TextStyle(fontSize: 12,color: AppColors.whiteColor),
                          buttonType: ButtonType.upImage,
                          onPress: () {
                            widget.onPress(2);
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
