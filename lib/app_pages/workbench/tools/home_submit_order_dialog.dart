
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class HomeSubmitOrderDialog extends StatefulWidget {

  final Function btnPress;
  const HomeSubmitOrderDialog({
    Key key,
    this.btnPress
  }) : super(key: key);

  @override
  _HomeSubmitOrderDialogState createState() => _HomeSubmitOrderDialogState();
}

class _HomeSubmitOrderDialogState extends State<HomeSubmitOrderDialog> {

  TextEditingController _editingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  double height = 35.0;
  int millisecond = 10000000;
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
        millisecond = millisecond-10;
        milli = millisecond%1000~/10;
        second = millisecond~/1000%60;
        min = millisecond/1000~/60%60;
        hour = millisecond/1000~/3600;
      });
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
    return KeyboardActionWidget(list: [_focusNode], child: Material(
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
                Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.black12Color,width: 1.0))
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 50.0,),
                      Expanded(
                        child: TextContainer(
                            alignment: Alignment.center,
                            title: '报单',
                            height: 50,
                            style: TextStyle(
                                fontSize: Dimens.font_sp18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor
                            )
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: AppButton(title: null,buttonType: ButtonType.onlyImage, image: '关闭',imageSize: 15, onPress: (){
                          Navigator.pop(context);
                        }),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  height: 45,
                  child: AppTextField(
                      controller: _editingController,
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      hintText: '请输入客户的手机号',
                      focusNode: _focusNode
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextContainer(
                          alignment: Alignment.centerLeft,
                          title: '您也可以让客户扫描下面的二维码进行开单',
                          height: 40,
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.black54Color
                          )
                      ),
                      Container(
                        height: 160,
                        alignment: Alignment.center,
                        child: LoadImage('',holderImg: 'defaultImage',height: 150.0,width: 150.0,radius: 0.0,),
                      ),
                      Container(
                        height: 35.0,
                        alignment: Alignment.center,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(fontSize: 14,color: AppColors.black54Color),
                                children: [
                                  TextSpan(
                                      text: '二维码剩余时间:'
                                  ),
                                  TextSpan(
                                    text: '${hour>=10?'$hour':'0$hour'}:${min>=10?'$min':'0$min'}:${second>=10?'$second':'0$second'}.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.red,
                                    ),
                                  ),
                                  TextSpan(
                                      text: '${milli>9?'$milli':'0$milli'}',
                                      style: TextStyle(
                                          fontSize: 14, color: AppColors.red))
                                ])),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  height: 70.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                        child: AppButton(title: '开始服务',radius: 50.0,bgColor: AppColors.mainColor,textStyle: TextStyles.whiteAnd14, image: null, onPress: (){
                          Navigator.pop(context);
                          widget.btnPress();
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
