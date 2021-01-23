

import 'package:demo/public_header.dart';
import 'package:flutter/material.dart';

class AppBoldText extends StatelessWidget {
  final String text;
  final double fonSize;
  final Color color;
  final Alignment alignment;

  const AppBoldText({
    Key key,
    @required this.text,
    this.fonSize = 14,
    this.color = AppColors.blackColor,
    this.alignment = Alignment.center
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(text,style: TextStyle(fontSize: fonSize,color: color,fontWeight: FontWeight.bold),),
    );
  }
}
