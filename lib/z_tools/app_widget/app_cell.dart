
import 'package:demo/public_header.dart';
import 'package:flutter/material.dart';

class AppCell extends StatelessWidget {

  final String title;
  final String content;
  final double height;
  final EdgeInsets edgeInsets;
  final Alignment alignment;
  final TextStyle titleStyle;
  final TextStyle contentStyle;
  final Widget leftWidget;

  const AppCell({
    Key key,
    @required this.title,
    @required this.content,
    this.height = 45.0,
    this.edgeInsets = const EdgeInsets.only(left: 16,right: 16),
    this.alignment = Alignment.centerLeft,
    this.titleStyle = const TextStyle(fontSize: Dimens.font_sp14, color: AppColors.blackColor),
    this.contentStyle = const TextStyle(fontSize: Dimens.font_sp13, color: AppColors.black54Color),
    this.leftWidget
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets,
      height: height,
      alignment: alignment,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          leftWidget??SizedBox(),
          SizedBox(width: leftWidget==null?0:5,),
          Text(title,style: titleStyle,),
          Gaps.hGap10,
          Expanded(
              child: Text(content,textAlign: TextAlign.right,style: contentStyle,)
          ),
        ],
      ),
    );
  }
}
