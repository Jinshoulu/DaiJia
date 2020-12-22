
import 'package:flutter/material.dart';

import '../../public_header.dart';

class AppLikeTextFieldButton extends StatefulWidget {

  final String text;
  final Function onPress;
  final String hintText;

  const AppLikeTextFieldButton({
    Key key,
    this.text,
    @required this.onPress,
    @required this.hintText
  }) : super(key: key);

  @override
  _AppLikeTextFieldButtonState createState() => _AppLikeTextFieldButtonState();
}

class _AppLikeTextFieldButtonState extends State<AppLikeTextFieldButton> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onPress();
      },
      child: Container(
        height: 50.0,
        padding: EdgeInsets.only(left: 16,right: 0),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.black33Color,width: 0.8),
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.text??widget.hintText,style: TextStyle(fontSize: Dimens.font_sp14,color: widget.text==null?AppColors.black54Color:AppColors.blackColor),),
                )
            ),
            Container(
              width: 50,
              child: Center(
                child: LoadAssetImage('ic_arrow_right', height: 15.0, width: 15.0,color: AppColors.black54Color,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
