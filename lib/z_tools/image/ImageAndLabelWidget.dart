
import 'package:flutter/material.dart';

import '../../public_header.dart';

enum ImageAndLabelType{
  leftImage,
  rightImage,
  upImage,
  downImage,
  lineLeftImage
}

class ImageAndLabelWidget extends StatefulWidget {

  final String image;
  final String title;
  final ImageAndLabelType type;

  final double imageSize;
  final TextStyle style;
  final double width;
  final double height;
  final EdgeInsets edgeInsets;

  const ImageAndLabelWidget({
    Key key,
    @required this.image,
    @required this.title,
    @required this.type,
    this.imageSize = 28,
    this.style = const TextStyle(fontSize: Dimens.font_sp12,color: AppColors.blackColor),
    this.edgeInsets = const EdgeInsets.only(left: 10,right: 10),
    this.width = 70,
    this.height = 30
  }) : super(key: key);


  @override
  _ImageAndLabelWidgetState createState() => _ImageAndLabelWidgetState();
}

class _ImageAndLabelWidgetState extends State<ImageAndLabelWidget> {
  @override
  Widget build(BuildContext context) {
    switch(widget.type){
      case ImageAndLabelType.leftImage:
        {
          return createLeftImageWidget();
        }
        break;
      case ImageAndLabelType.lineLeftImage:
        {
          return createLineWidget();
        }
        break;
      default:
        {
          return createUpImage();
        }
        break;
    }
  }

  createLineWidget(){
    return Container(
      height: widget.height,
      padding: widget.edgeInsets,
      decoration: BoxDecoration(
        borderRadius:BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: AppColors.black33Color,width: 1.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              width: widget.height,
              alignment: Alignment.center,
              child: widget.image.contains('http')?
              LoadImage(widget.image,width: widget.imageSize,radius: 0.0,)
                  :
              LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0,)
          ),
          Gaps.hGap5,
          Container(
              alignment: Alignment.centerLeft,
              child: Text(widget.title,style: widget.style,))
        ],
      ),
    );
  }

  ///左图右文字
  createLeftImageWidget(){
    return Container(
      height: widget.height,
      padding: widget.edgeInsets,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: widget.height,
              alignment: Alignment.center,
              child: widget.image.contains('http')?
              LoadImage(widget.image,width: widget.imageSize,radius: 0.0,)
                  :
              LoadAssetImage(widget.image,width: widget.imageSize,fit: BoxFit.fitWidth,radius: 0.0,)
          ),
          Gaps.hGap5,
          Container(
              alignment: Alignment.centerLeft,
              child: Text(widget.title,style: widget.style,))
        ],
      ),
    );
  }

  ///上图下文字
  createUpImage(){
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.edgeInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                width: widget.width,
                height: widget.height-20,
                alignment: Alignment.center,
                child: LoadAssetImage(widget.image,width: widget.imageSize,height: widget.imageSize,radius: 0.0,fit: BoxFit.contain,)),
          ),
          Gaps.hGap5,
          Container(
              alignment: Alignment.center,
              height: 20,
              child: Text(widget.title,style: widget.style,)
          )
        ],
      ),
    );
  }
}
