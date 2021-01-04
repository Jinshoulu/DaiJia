
import 'package:demo/public_header.dart';
import 'package:flutter/material.dart';

class AppSizeBox extends StatelessWidget {

  final double height;
  final double width;
  final Color color;
  const AppSizeBox({
    Key key,
    this.height = 10.0,
    this.color = AppColors.bgColor,
    this.width = double.infinity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: color
          )
      ),
    );
  }
}
