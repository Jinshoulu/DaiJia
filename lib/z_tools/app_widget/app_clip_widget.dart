
import 'package:demo/public_header.dart';
import 'package:flutter/material.dart';

class AppClipWidget extends StatelessWidget {

  final double width;
  final double height;
  final Widget child;
  final Color bgColor;
  final Alignment alignment;

  const AppClipWidget({
    Key key,
    @required this.width,
    @required this.height,
    @required this.child,
    this.bgColor = AppColors.whiteColor,
    this.alignment = Alignment.center
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(width>height?width:height)),
      child: Container(
        width: width,height: height,
        color: bgColor,
        alignment: alignment,
        child: child,
      ),
    );
  }
}
