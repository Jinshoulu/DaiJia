
import 'package:flutter/material.dart';
import '../../public_header.dart';

class AppSetCell extends StatelessWidget {
  final String title;
  final String content;
  final bool showRightImage;
  final bool showLine;
  final Function onPress;
  final double height;
  final Color rightColor;
  final Color titleColor;
  final Color imageColor;
  final Widget leftWidget;
  final Color  bgColor;
  final Color  lineColor;

  const AppSetCell({
    Key key,
    @required this.title,
    @required this.onPress,
    this.content = '',
    this.showRightImage = true,
    this.showLine = true,
    this.height = 50,
    this.rightColor = AppColors.blackColor,
    this.titleColor = AppColors.blackColor,
    this.imageColor = AppColors.blackColor,
    this.leftWidget,
    this.bgColor = AppColors.whiteColor,
    this.lineColor = AppColors.bgColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(onPress!=null){
          onPress();
        }
      },
        child: Container(
          padding: EdgeInsets.only(left: 12,right: 10),
          height: height,
          alignment: Alignment.centerLeft,
          color: bgColor,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      leftWidget??SizedBox(),
                      leftWidget==null?SizedBox():Gaps.hGap5,
                      Text(title,style: TextStyle(fontSize: Dimens.font_sp14,color: titleColor),),
                      Gaps.hGap10,
                      Expanded(
                          child: Text(content,textAlign: TextAlign.right,style: TextStyle(fontSize: Dimens.font_sp12,color: rightColor),)
                      ),
                      Gaps.hGap5,
                      showRightImage?Container(
                        child: Center(
                          child: LoadAssetImage('ic_arrow_right', height: 12.0, width: 12.0,color: imageColor,),
                        ),
                      ):SizedBox()
                    ],
                  )
              ),
              Positioned(
                  left: 0,
                  right: 10,
                  bottom: 0,
                  child:showLine?SizedBox(
                    height: 1,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: lineColor
                      ),
                    ),
                  ):SizedBox()
              )
            ],
          ),
        )
    );
  }
}
