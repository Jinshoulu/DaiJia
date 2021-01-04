
import 'package:flutter/material.dart';

import '../../public_header.dart';

class OperateDialog extends StatefulWidget {

  final String title;
  final String cancelText;
  final String content;
  final String sureText;
  final Function surePress;

  const OperateDialog({Key key, this.title='温馨提示', this.cancelText = '取消', this.sureText = '确定', this.surePress, this.content=''}) : super(key: key);


  @override
  _OperateDialogState createState() => _OperateDialogState();
}

class _OperateDialogState extends State<OperateDialog> {


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
                      height: 60.0,
                      width: 280.0,
                      child: Center(child: Text(widget.title, style: TextStyles.blackAnd14)),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(widget.content, style: TextStyles.blackAnd14),
                  ),
                  Gaps.vGap10,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0 , top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
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
}
