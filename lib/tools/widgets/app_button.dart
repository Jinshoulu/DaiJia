
import 'package:flutter/material.dart';

import '../../public_header.dart';

enum ButtonType{
  onlyText,//只有文字
  onlyImage,//只有图片
  leftImage,//左图右文字
  rightImage,//右图左文字
  upImage,//上图下文字
  downImage//下图上文字
}

class AppButton extends StatefulWidget {
  final EdgeInsets edgeInsets;
  final String title;
  final String image;
  final TextStyle textStyle;
  final Color imageColor;
  final Color bgColor;
  final Function onPress;
  final ButtonType buttonType;
  final Alignment alignment;
  final double radius;
  final double imageSize;



  const AppButton({
    Key key,
    this.edgeInsets = const EdgeInsets.only(left: 5,right: 5),
    this.title,
    this.image,
    this.textStyle = const TextStyle(fontSize: Dimens.font_sp12,color: Colors.black),
    this.imageColor,
    this.onPress,
    this.bgColor = Colors.transparent,
    this.buttonType = ButtonType.onlyText,
    this.alignment = Alignment.center,
    this.radius = 8.0,
    this.imageSize = 25.0
  }) : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onPress();
      },
      child: Container(
        alignment: widget.alignment,
        padding: widget.edgeInsets,
        decoration: BoxDecoration(
            color:  widget.bgColor,
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        ),
        child: create(widget.buttonType),
      ),
    );
  }

  create(ButtonType type){
    switch(type){
      case ButtonType.onlyText:{
        return Text(widget.title,style: widget.textStyle,);
      }break;
      case ButtonType.onlyImage:{
        return widget.image.contains('http')?LoadImage(widget.image,radius: widget.radius,):LoadAssetImage(widget.image,radius: widget.radius,);
      }break;
      case ButtonType.leftImage:{
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: widget.imageColor==null?
              LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0)
                  :LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0,color: widget.imageColor,),
            ),
            SizedBox(width: 5,),
            Expanded(child: Text(widget.title,style: widget.textStyle,))
          ],
        );
      }break;
      case ButtonType.rightImage:{
        return SizedBox();
      }break;
      case ButtonType.upImage:{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: SizedBox()),
            Container(
              width: widget.imageSize,
              height: widget.imageSize,
              child: widget.image.contains('http')?LoadImage(widget.image,radius: widget.radius,):LoadAssetImage(widget.image,radius: widget.radius,),
            ),
            Container(
              height: 20.0,
              child: Text(widget.title,style: widget.textStyle,),
            ),
            Expanded(child: SizedBox()),
          ],
        );
      }break;
      case ButtonType.downImage:{
        return SizedBox();
      }break;
      default:{
        return SizedBox();
      }break;
    }
  }
}
