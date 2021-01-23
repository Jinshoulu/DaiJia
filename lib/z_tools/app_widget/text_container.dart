
import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String title;
  final double height;
  final TextStyle style;
  final Alignment alignment;
  final bool showBottomSlide;
  final Color slideColor;
  final Color bgColor;

  const TextContainer({
    Key key,
    @required this.title,
    @required this.height,
    @required this.style,
    this.alignment = Alignment.centerLeft,
    this.showBottomSlide = false,
    this.slideColor,
    this.bgColor = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showBottomSlide
        ? Container(
            margin: EdgeInsets.only(bottom: 10),
            alignment: alignment,
            height: height,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: slideColor,width: 1)),
              color: bgColor,
            ),
            child: Text(
              title,
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : Container(
            alignment: alignment,
            height: height,
            child: Text(
              title,
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          );
  }
}
