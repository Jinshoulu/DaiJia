
import 'package:flutter/material.dart';

import '../../public_header.dart';

class ContainerAddLineWidget extends StatefulWidget {

  final double height;
  final Color bgColor;
  final Color lineColor;
  final EdgeInsets edgeInsets;
  final double disW;
  final Widget child;

  const ContainerAddLineWidget({
    Key key,
    this.height = 50.0,
    this.edgeInsets = const EdgeInsets.only(left: 16,right: 10),
    this.disW = 16.0,
    @required this.child,
    this.bgColor = ColorsApp.whiteColor,
    this.lineColor = AppColors.bgColor
  }) : super(key: key);

  @override
  _ContainerAddLineWidgetState createState() => _ContainerAddLineWidgetState();
}

class _ContainerAddLineWidgetState extends State<ContainerAddLineWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      height: widget.height,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Padding(
              padding: widget.edgeInsets,
              child: widget.child,
            ),
          ),
          Positioned(
              left: widget.disW,
              bottom: 0,
              right: widget.disW,
              child: SizedBox(
                width: double.infinity,
                height: 1,
                child:  DecoratedBox(decoration: BoxDecoration(color: widget.lineColor)),
              )
          )
        ],
      ),
    );
  }
}
