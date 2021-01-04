
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../public_header.dart';

class OperateEmptyDialog extends StatefulWidget {

  final Widget topWidget;
  final Widget centerWidget;
  final Widget bottomWidget;

  final double width;
  final double radius;
  final double disWidth;

  final Color bgColor;


  const OperateEmptyDialog({
    Key key,
    @required this.topWidget,
    @required this.centerWidget,
    @required this.bottomWidget,
    this.width = 280.0,
    this.radius = 8.0,
    this.disWidth = 16.0,
    this.bgColor,
  }) : super(key: key);



  @override
  _OperateEmptyDialogState createState() => _OperateEmptyDialogState();
}

class _OperateEmptyDialogState extends State<OperateEmptyDialog> {


  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: (){
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
                padding: EdgeInsets.all(widget.disWidth),
                decoration: BoxDecoration(
                  color: widget.bgColor==null?ThemeUtils.getDialogBackgroundColor(context):widget.bgColor,
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                width: widget.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.topWidget,
                    widget.centerWidget,
                    widget.bottomWidget,
                  ],
                )
            ),
          )
      ),
    );
  }
}
