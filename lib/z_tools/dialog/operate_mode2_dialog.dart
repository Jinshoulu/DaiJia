
import 'package:flutter/material.dart';

import '../../public_header.dart';

class OperateMode2Dialog extends StatelessWidget {

  final String title;
  final String cancelText;
  final String content;
  final String sureText;
  final Function surePress;

  const OperateMode2Dialog({
    Key key,
    this.title = '温馨提示',
    this.content = '',
    this.cancelText = '取消',
    this.sureText = '确定',
    @required this.surePress
  }) : super(key: key);

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
              width: 280.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 55.0,
                    width: 280.0,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.0,color: AppColors.bgColor))
                    ),
                    child: Center(child: Text(title, style: TextStyles.getBlackBoldText(15))),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    height: 80,
                    alignment: Alignment.center,
                    child: Text(content,textAlign: TextAlign.center, style: TextStyles.blackAnd14),
                  ),
                  Gaps.vGap10,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0 , top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          width: 110.0,
                          height: 36.0,
                          child: AppButton(
                              title: cancelText,
                              textStyle: TextStyle(fontSize: 14,color: AppColors.black54Color),
                              radius: 36.0,
                              bgColor: AppColors.bgColor,
                              image: null,
                              onPress: (){
                                AppPush.goBack(context);
                              }
                          ),
                        ),
                        SizedBox(
                          width: 110.0,
                          height: 36.0,
                          child: AppButton(
                              title: sureText,
                              textStyle: TextStyle(fontSize: 14,color: AppColors.whiteColor),
                              bgColor: AppColors.mainColor,
                              radius: 36.0,
                              image: null,
                              onPress: (){
                                AppPush.goBack(context);
                                surePress();
                              }
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
}
