
import 'package:flutter/material.dart';

import '../../public_header.dart';


class AppImageAndLabel extends StatelessWidget {

  final String image;
  final String title;
  final String content;
  final double height;
  final double imageSize;
  final bool showLine;
  final Color bgColor;
  final Color titleColor;
  final Color contentColor;
  final bool isLeft;
  final Function onPress;
  final double disWith; //图片与文件之间的间距
  final bool showRightImage;
  final Widget rightWidget;
  final Color lineColor;
  final Color imageColor;
  final double radius;
  final EdgeInsets edgeInsets;

  const AppImageAndLabel({
    Key key,
    @required this.image,
    @required this.title,
    this.height = 50.0,
    this.showLine = true,
    this.bgColor = Colors.white,
    this.titleColor = Colors.black,
    this.isLeft = true,
    this.onPress,
    this.imageSize = 40.0,
    this.disWith = 10.0, 
    this.showRightImage = true,
    this.rightWidget,
    this.content,
    this.contentColor = AppColors.black54Color,
    this.lineColor = AppColors.bgColor,
    this.imageColor = AppColors.black87Color,
    this.edgeInsets, this.radius = 0.0
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPress();
      },
      child: Container(
        padding: edgeInsets??EdgeInsets.only(left: 16,right: 10),
        height: height,
        alignment: isLeft?Alignment.centerLeft:Alignment.centerRight,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color:showLine?lineColor:AppColors.transparentColor,width: 1)),
          color: bgColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            image.contains('http')?
            LoadImage(image,height: imageSize,width: imageSize,radius: radius,):
            LoadAssetImage(image,height: imageSize,width: imageSize,radius: radius,),
            SizedBox(width: disWith,),
            Expanded(
                child: Text(title,style: TextStyle(color: titleColor,fontSize: Dimens.font_sp14),)
            ),
            content==null?SizedBox():Expanded(
                child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(content,style: TextStyle(color: contentColor,fontSize: Dimens.font_sp14),)
                )
            ),
            rightWidget??(showRightImage?Container(
              child: Center(
                child: LoadAssetImage('ic_arrow_right',height: 15,width: 15,fit: BoxFit.contain,color: imageColor,),
              ),
            ):SizedBox())
          ],
        ),
      ),
    );
  }
}
