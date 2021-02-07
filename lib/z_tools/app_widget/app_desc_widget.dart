
import 'package:flutter/material.dart';

import '../../public_header.dart';

class AppDescWidget extends StatefulWidget {

  final String text;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final int maxLines;
  final Color bgColor;
  final TextStyle textStyle;
  final double fonSize;
  final Color textColor;

  const AppDescWidget({
    Key key,
    @required this.text,
    this.margin = const EdgeInsets.only(left: 16,right: 16),
    this.padding = const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
    this.maxLines = 200,
    this.bgColor = AppColors.inputBgColor,
    this.textStyle,
    this.fonSize = 14.0,
    this.textColor = AppColors.black54Color
  }) : super(key: key);


  @override
  _AppDescWidgetState createState() => _AppDescWidgetState();
}

class _AppDescWidgetState extends State<AppDescWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: widget.bgColor
      ),
      child: Text(
        widget.text,
        overflow: TextOverflow.ellipsis,
        maxLines: widget.maxLines,
        style: widget.textStyle??TextStyle(fontSize: widget.fonSize,color: widget.textColor),
      ),
    );
  }
}
