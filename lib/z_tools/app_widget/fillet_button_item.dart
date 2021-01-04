
import 'package:flutter/material.dart';
import '../../public_header.dart';

class FilletButtonItem extends StatelessWidget {

  final double width;
  final double height;
  final Color bgColor;
  final String title;
  final Color titleColor;
  final double fontSize;
  final double radius;
  final Function onPress;

  const FilletButtonItem({
    Key key,
    this.width = 60.0,
    this.height = 30.0,
    this.bgColor = Colors.white,
    this.title = '按钮',
    this.titleColor = Colors.black,
    this.fontSize = Dimens.font_sp12,
    this.radius = 8.0,
    this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
        onPress();
      },
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            color: bgColor
        ),
        child: Text(title,style: TextStyle(
            fontSize: fontSize,
            color: titleColor
        ),),
      ),
    );
  }
}


