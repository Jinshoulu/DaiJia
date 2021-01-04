
import 'dart:async';

import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class ShowPushOrderDialog extends StatefulWidget {

  final Function btnPress;

  const ShowPushOrderDialog({
    Key key,
    this.btnPress
  }) : super(key: key);


  @override
  _ShowPushOrderDialogState createState() => _ShowPushOrderDialogState();
}

class _ShowPushOrderDialogState extends State<ShowPushOrderDialog> {

  double height = 35.0;

  int millisecond = 0;
  Timer _timer;
  int hour = 0;
  int min = 0;
  int second = 0;
  int milli = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 10), (value){
      setState(() {
        millisecond = millisecond+10;
        milli = millisecond%1000~/10;
        second = millisecond~/1000%60;
        min = millisecond/1000~/60;
        hour = millisecond/1000~/3600;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextContainer(
                    showBottomSlide: true,
                    slideColor: AppColors.black54Color,
                    alignment: Alignment.center,
                    title: '系统推送单',
                    height: 50,
                    style: TextStyle(
                        fontSize: Dimens.font_sp18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor
                    )
                ),
                Container(
                  height: 260.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppCell(
                        title: '客户位置',
                        content: '金成时代广场(600m)',
                        height: height,
                      ),
                      AppCell(
                        title: '目的地',
                        content: '绿博园',
                        height: height,
                      ),
                      AppCell(
                        title: '行程',
                        content: '25.00km',
                        height: height,
                      ),
                      AppCell(
                        title: '客户电话',
                        content: '17752521882',
                        height: height,
                      ),
                      AppCell(
                        title: '接单计时',
                        content: '',
                        height: height,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(
                                  text: '${hour>=10?'$hour':'0$hour'}:${min>=10?'$min':'0$min'}:${second>=10?'$second':'0$second'}.',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: AppColors.red,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: '${milli>9?'$milli':'0$milli'}',
                                        style: TextStyle(
                                            fontSize: 14, color: AppColors.red))
                                  ])),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  height: 100.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: AppButton(title: '接单',radius: 50.0,bgColor: AppColors.mainColor,textStyle: TextStyles.whiteAnd14, image: null, onPress: (){
                            Navigator.pop(context);
                            widget.btnPress(0);
                        }),
                      ),
                      SizedBox(height: 20.0,),
                      Expanded(
                        child: AppButton(title: '拒接',radius: 50.0,bgColor: AppColors.red,textStyle: TextStyles.whiteAnd14, image: null, onPress: (){
                          Navigator.pop(context);
                          widget.btnPress(1);
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
