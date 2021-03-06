
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';


class ShowEmptyBar extends StatelessWidget implements PreferredSizeWidget{

  final Color backgroundColor;
  final Widget leftWidget;
  final Widget rightWidget;
  final Widget centerWidget;
  final String title;
  final TextStyle style;

  const ShowEmptyBar({
    Key key,
    this.backgroundColor = Colors.white,
    this.leftWidget,
    this.rightWidget,
    this.centerWidget,
    this.title,
    this.style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemUiOverlayStyle _overlayStyle = ThemeUtils.isDark(context) ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: backgroundColor,
        child: SafeArea(
          child: Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                leftWidget??SizedBox(
                  width: 48.0,
                  child: IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      AppPush.goBack(context);
                    },
                    tooltip: 'Back',
                    padding: const EdgeInsets.all(12.0),
                    icon: Image.asset(
                      'assets/images/back_black.png',
                      color: ThemeUtils.isDark(context) ? AppColors.whiteColor : AppColors.blackColor,
                    ),
                  ),
                ),
                Expanded(
                  child: centerWidget??TextContainer(
                      alignment: Alignment.center,
                      title: title,
                      height: double.infinity,
                      style: style
                  ),
                ),
                rightWidget??SizedBox(width: 48.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
