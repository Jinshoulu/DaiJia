
import 'package:flutter/material.dart';

import '../../public_header.dart';

class CustomerServiceDialog extends StatefulWidget {

  final String image;
  final String content;
  final String title;
  final String cancelText;
  final String sureText;
  final bool isHiddenCancel;
  final Function surePress;
  final double width;
  final double imageSize;

  const CustomerServiceDialog({
    Key key,
    @required this.surePress,
    @required this.content,

    this.title = '人工客服电话',
    this.image = 'customerServiceImage',
    this.cancelText = '取消',
    this.sureText = '立即拨打',
    this.isHiddenCancel = false,
    this.width = 280.0,
    this.imageSize = 80.0

  }) : super(key: key);

  @override
  _CustomerServiceDialogState createState() => _CustomerServiceDialogState();
}

class _CustomerServiceDialogState extends State<CustomerServiceDialog> {

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              padding: EdgeInsets.only(top: 30,bottom: 20),
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
                    child: Center(
                        child: LoadAssetImage(widget.image,height: widget.imageSize,fit: BoxFit.fitHeight,radius: 0.0,)
                    ),
                  ),
                  Gaps.vGap10,
                  widget.isHiddenCancel?SizedBox():Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(widget.title, style: TextStyle(color: AppColors.mainColor,fontSize: Dimens.font_sp16)),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(widget.content, style: TextStyle(fontSize: Dimens.font_sp14,color: Colors.black))
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
                            color: AppColors.bgColor,
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
                        widget.isHiddenCancel?SizedBox():Gaps.hGap10,
                        Container(
                          width: 110.0,
                          height: 36.0,
                          child: FlatButton(
                            onPressed: () {
                              AppPush.goBack(context);
                              widget.surePress(widget.content);
                            },
                            textColor: Colors.white,
                            color: AppColors.mainColor,
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
