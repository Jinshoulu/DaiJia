
import 'package:flutter/material.dart';

import '../../public_header.dart';

class AppTitleAndWidget extends StatelessWidget {

  final String title;
  final Widget child;
  final double height;
  final Function onPress;

  const AppTitleAndWidget({Key key, this.title = '', this.height = 50.0, this.onPress, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Text(title,style: TextStyle(fontSize: Dimens.font_sp14,color: ThemeUtils.isDark(context)?AppColors.whiteColor:AppColors.blackColor),)
            ),
            child??SizedBox()
          ],
        ),
      ),
    );
  }
}
