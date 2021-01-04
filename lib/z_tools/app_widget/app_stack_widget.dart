
import 'package:flutter/material.dart';

class AppStackWidget extends StatelessWidget {

  final double height;
  final Widget topWidget;
  final Widget downWidget;
  final bool isUp;

  const AppStackWidget({
    Key key,
    this.height = 50.0,
    @required this.topWidget,
    @required this.downWidget,
    this.isUp = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isUp?createUp():createDown();
  }

  createUp(){
    return Stack(
      children: <Widget>[
        Positioned(
            left: 0, top: 0,right: 0,
            child: topWidget??SizedBox(height: height,)
        ),
        Positioned(
            left: 0,top: height,right: 0,bottom: 0,
            child: downWidget??SizedBox()
        ),
      ],
    );
  }

  createDown(){
    return Stack(
      children: <Widget>[
        Positioned(
            left: 0,top: 0,right: 0,bottom: height,
            child: topWidget??SizedBox()
        ),
        Positioned(
            left: 0,right: 0,bottom: 0,
            child: downWidget??SizedBox(height: height,)
        ),
      ],
    );
  }
}
