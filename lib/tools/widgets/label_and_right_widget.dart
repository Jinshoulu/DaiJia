
import 'package:flutter/material.dart';

import '../../public_header.dart';


class LabelAndRightWidget extends StatelessWidget {

  final String title;
  final Widget rightWidget;
  final TextStyle style;
  final double height;
  final EdgeInsets edgeInsets;
  final bool showRightImage;
  final Color imageColor;

  const LabelAndRightWidget({
    Key key,
    @required this.title,
    @required this.rightWidget,
    this.style = const TextStyle(fontSize: Dimens.font_sp14,color: Colors.black),
    this.height = 45,
    this.edgeInsets = const EdgeInsets.only(left: 16,right: 16),
    this.showRightImage = false,
    this.imageColor
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets,
      height: height,
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            child: Text(title,style: style,),
          )),
          rightWidget,
          showRightImage?Container(
            child: Center(
              child: imageColor==null?LoadAssetImage('ic_arrow_right',width: 15, fit: BoxFit.fitWidth,radius: 0.0,):LoadAssetImage('ic_arrow_right', width: 15.0, fit: BoxFit.fitWidth, color: imageColor,),
            ),
          ):SizedBox()
        ],
      ),
    );
  }
}
