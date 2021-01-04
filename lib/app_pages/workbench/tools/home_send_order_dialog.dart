
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class HomeSendOrderDialog extends StatefulWidget {
  final Function btnPress;
  final String title;
  final String btnTitle;
  final Widget centerWidget;

  const HomeSendOrderDialog({Key key, this.btnPress,@required this.centerWidget, this.title = '温馨提示', this.btnTitle = '确认'}) : super(key: key);

  @override
  _HomeSendOrderDialogState createState() => _HomeSendOrderDialogState();
}

class _HomeSendOrderDialogState extends State<HomeSendOrderDialog> {
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
                            title: widget.title,
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
                      )
                    ],
                  ),
                ),
                widget.centerWidget,
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  height: 70.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                        child: AppButton(title: widget.btnTitle,radius: 50.0,bgColor: AppColors.mainColor,textStyle: TextStyles.whiteAnd14, image: null, onPress: (){
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
    );
  }
}
