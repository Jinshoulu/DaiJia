
import 'package:demo/z_tools/app_widget/app_button.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class MineSingleItem extends StatefulWidget {

  final double height;
  final String title;
  final String time;
  final bool showCancel;
  final Function onPress;

  const MineSingleItem({
    Key key,
    @required this.title,
    @required this.time,
    this.height = 55.0,
    this.showCancel = false,
    this.onPress
  }) : super(key: key);


  @override
  _MineSingleItemState createState() => _MineSingleItemState();
}

class _MineSingleItemState extends State<MineSingleItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      height: widget.height,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          width: 1,
          color: AppColors.bgColor
        ))
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            padding: EdgeInsets.only(top: 5,bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Container(alignment: Alignment.centerLeft,child: Text(widget.title,style: TextStyle(fontSize: 14),))),
                Expanded(child: Container(alignment: Alignment.centerLeft,child: Text(widget.time,style: TextStyle(fontSize: 12),)))
              ],
            ),
          )),
          widget.showCancel?Container(
            width: 60.0,
            height: widget.height,
            alignment: Alignment.center,
            child: SizedBox(
              height: 30.0,
              child: AppButton(title: '取消',radius: 30.0,bgColor: AppColors.red,textStyle: TextStyle(fontSize: 14,color: Colors.white), image: null, onPress: (){
                  widget.onPress();
              }),
            ),
          ):SizedBox()
        ],
      ),
    );
  }
}
