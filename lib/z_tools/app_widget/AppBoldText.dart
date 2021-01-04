

import 'package:demo/public_header.dart';
import 'package:flutter/material.dart';

class AppBoldText extends StatelessWidget {
  final String text;
  final double fonSize;
  final Color color;

  const AppBoldText({
    Key key,
    @required this.text,
    this.fonSize = 14,
    this.color = AppColors.blackColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(text,style: TextStyle(fontSize: fonSize,color: color,fontWeight: FontWeight.bold),),
    );
  }
}
