
import 'package:flutter/material.dart';

import '../../public_header.dart';


class OperateBGImageDialog extends StatefulWidget {

  final double width;
  final double height;
  final double radius;
  final double disWidth;
  final Function surePress;
  final String title;
  final String content;
  final String bgImage;
  final String btnImage;
  final String sureText;

  const OperateBGImageDialog({
    Key key,
    this.width = 280.0,
    this.height = 280.0,
    this.radius = 8.0,
    this.disWidth = 10.0,
    this.surePress,
    this.title = '温馨提示',
    this.content = '',
    this.bgImage = '忘记密码弹窗背景',
    this.btnImage = '忘记密码按钮背景',
    this.sureText = '确认',
  }) : super(key: key);

  @override
  _OperateBGImageDialogState createState() => _OperateBGImageDialogState();
}

class _OperateBGImageDialogState extends State<OperateBGImageDialog> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              padding: EdgeInsets.all(widget.disWidth),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
              ),
              width: widget.width,
              height: widget.height,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  LoadAssetImage(widget.bgImage),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(widget.title,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                              fontSize: Dimens.font_sp18
                          ),),
                        ),
                        Gaps.vGap32,
                        Container(
                          alignment: Alignment.center,
                            child: Text(widget.content,style: TextStyles.blackAnd14,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )
                        ),
                        Expanded(child: SizedBox()),
                        Center(
                          child: InkWell(
                            onTap: (){
                              widget.surePress();
                            },
                            child: Container(
                              height: 30,
                              width: 120,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  LoadAssetImage(widget.btnImage),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(widget.sureText,style: TextStyle(
                                        fontSize: Dimens.font_sp16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor
                                    ),),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 70,)
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
