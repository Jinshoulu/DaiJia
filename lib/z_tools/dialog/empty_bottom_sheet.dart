
import 'package:demo/public_header.dart';
import 'package:flutter/material.dart';

class EmptyBottomSheet extends StatelessWidget {

  final Widget topWidget;
  final Widget centerWidget;
  final Widget downWidget;
  final EdgeInsets edgeInsets;

  const EmptyBottomSheet({
    Key key, 
    @required this.topWidget,
    @required this.centerWidget,
    @required this.downWidget,
    this.edgeInsets = const EdgeInsets.only(left: 16, right: 16, bottom: 30),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: Container(
            padding: edgeInsets,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[topWidget, centerWidget, downWidget],
            ),
          ),
        ),
      ),
    );
  }
}
