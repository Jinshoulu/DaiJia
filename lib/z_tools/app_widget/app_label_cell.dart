
import 'package:flutter/material.dart';
import '../../public_header.dart';

class AppLabelCell extends StatelessWidget {
  final String title;
  final bool showRightImage;
  final bool showLine;
  final Function onPress;
  final double height;
  final Color rightColor;
  final EdgeInsets edgeInsets;
  final String image;
  final double imageSize;
  final double disW;
  const AppLabelCell({
    Key key,
    this.title = '这是标题',
    this.showRightImage = true,
    this.showLine = true,
    this.onPress,
    this.height = 50,
    this.rightColor = AppColors.black54Color,
    this.edgeInsets,
    this.image,
    this.imageSize = 15,
    this.disW = 16

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
          alignment: Alignment.centerLeft,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      image==null?SizedBox():Container(
                        width: height,
                        alignment: Alignment.center,
                        child: LoadAssetImage(image,fit: BoxFit.fitWidth,width: imageSize,radius: 0.0,),
                      ),
                      Expanded(
                          child: Text(title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.blackColor),)
                      ),
                      showRightImage?Container(
                        child: Center(
                          child: Images.arrowRight,
                        ),
                      ):SizedBox()
                    ],
                  ),
              ),
              Positioned(
                  left: disW,
                  bottom: 0,
                  right: disW,
                  child: showLine?SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.bgColor)),
                  ):SizedBox(height: 1,)
              )
            ],
          ),
        )
    );
  }
}
