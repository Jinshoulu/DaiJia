
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

  const AppLabelCell({
    Key key,
    this.title = '这是标题',
    this.showRightImage = true,
    this.showLine = true,
    this.onPress,
    this.height = 50,
    this.rightColor = AppColors.black54Color,
    this.edgeInsets

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
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: showLine?AppColors.bgColor:Colors.transparent,
                    width: 1,
                  )
              ),
              color: Colors.white
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Text(title,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.blackColor),)
              ),
              showRightImage?Container(
                child: Center(
                  child: Images.arrowRight,
                ),
              ):SizedBox()
            ],
          ),
        )
    );
  }
}
