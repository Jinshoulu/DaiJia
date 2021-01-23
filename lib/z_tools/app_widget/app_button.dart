
import 'package:flutter/material.dart';

import '../../public_header.dart';

enum ButtonType{
  onlyText,//只有文字
  onlyImage,//只有图片
  leftImage,//左图右文字
  rightImage,//右图左文字
  upImage,//上图下文字
  downImage,//下图上文字
  leftImageAndRightImage//左图，中间文字 右图
}

class AppButton extends StatefulWidget {
  final EdgeInsets edgeInsets;
  final String title;
  final String image;
  final String rightImage;
  final TextStyle textStyle;
  final Color imageColor;
  final Color rightImageColor;
  final Color bgColor;
  final Function onPress;
  final ButtonType buttonType;
  final Alignment alignment;
  final MainAxisAlignment mainAxisAlignment;
  final double radius;
  final double imageSize;
  final double rightImageSize;
  final double textHeight;
  final double disW;

  const AppButton({
    Key key,
    @required this.title,
    @required this.onPress,
    this.image,
    this.edgeInsets = const EdgeInsets.only(left: 5,right: 5),
    this.textStyle = const TextStyle(fontSize: Dimens.font_sp14,color: Colors.black),
    this.imageColor,
    this.bgColor = Colors.transparent,
    this.buttonType = ButtonType.onlyText,
    this.alignment = Alignment.center,
    this.radius = 0.0,
    this.imageSize = 25.0,
    this.textHeight = 20.0,
    this.disW = 5.0,
    this.rightImage,
    this.rightImageColor,
    this.rightImageSize = 25.0,
    this.mainAxisAlignment = MainAxisAlignment.center
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
        return widget.image.contains('http')?LoadImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: widget.radius,):
        (widget.imageColor==null?
        LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: widget.radius,)
            :LoadAssetImage(widget.image,width: widget.imageSize,color: widget.imageColor,fit: BoxFit.fitWidth,radius: widget.radius,));
      }break;
      case ButtonType.leftImage:{
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: widget.mainAxisAlignment,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: widget.imageColor==null?
              LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0)
                  :LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0,color: widget.imageColor,),
            ),
            SizedBox(width: widget.disW,),
            SizedBox(child: Text(widget.title,style: widget.textStyle,))
          ],
        );
      }break;
      case ButtonType.rightImage:{
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: widget.mainAxisAlignment,
          children: <Widget>[
            SizedBox(child: Text(widget.title,style: widget.textStyle,)),
            SizedBox(width: widget.disW,),
            Container(
              alignment: Alignment.center,
              child: widget.imageColor==null?
              LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0)
                  :LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0,color: widget.imageColor,),
            ),
          ],
        );
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
              child: widget.image.contains('http')
                  ?LoadImage(widget.image,radius: widget.radius,)
                  :(widget.imageColor==null?LoadAssetImage(widget.image,radius: widget.radius,):LoadAssetImage(widget.image,color: widget.imageColor,radius: widget.radius,)),
            ),
            SizedBox(height: widget.disW,),
            Container(
              height: widget.textHeight,
              child: Text(widget.title,style: widget.textStyle,),
            ),
            Expanded(child: SizedBox()),
          ],
        );
      }break;
      case ButtonType.downImage:{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: SizedBox()),
            Container(
              height: widget.textHeight,
              child: Text(widget.title,style: widget.textStyle,),
            ),
            SizedBox(height: widget.disW,),
            Container(
              width: widget.imageSize,
              height: widget.imageSize,
              child: widget.image.contains('http')?LoadImage(widget.image,radius: widget.radius,):LoadAssetImage(widget.image,radius: widget.radius,),
            ),

            Expanded(child: SizedBox()),
          ],
        );
      }break;
      case ButtonType.leftImageAndRightImage:{
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: widget.mainAxisAlignment,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: widget.imageColor==null?
              LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0)
                  :LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0,color: widget.imageColor,),
            ),
            SizedBox(width: widget.disW,),
            SizedBox(child: Text(widget.title,style: widget.textStyle,)),
            SizedBox(width: widget.disW,),
            Container(
              alignment: Alignment.center,
              child: widget.rightImageColor==null?
              LoadAssetImage(widget.rightImage,width: widget.rightImageSize,fit: BoxFit.fitWidth,radius: 0.0)
                  :LoadAssetImage(widget.rightImage,width: widget.rightImageSize,fit: BoxFit.fitWidth,radius: 0.0,color: widget.rightImageColor,),
            ),
          ],
        );
      }break;
      default:{
        return SizedBox();
      }break;
    }
  }
}
