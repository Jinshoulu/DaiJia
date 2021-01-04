

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../public_header.dart';


/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MyAppBar({
    Key key,
    this.backgroundColor = AppColors.mainColor,
    this.title = '',
    this.centerTitleColor = AppColors.whiteColor,
    this.centerTitle = '',
    this.actionName = '',
    this.backImg = 'assets/images/back_black.png',
    this.onPressed,
    this.isBack = true,
    this.rightWidget,
    this.isBackHome = false,
    this.brightness = Brightness.light,
    this.backParameters,
  }): super(key: key);

  final Color backgroundColor;
  final String title;
  final Color centerTitleColor;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;
  final Widget rightWidget;
  final Brightness brightness;
  final bool isBackHome;
  final backParameters;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = ThemeUtils.getBackgroundColor(context);
    } else {
      _backgroundColor = ThemeUtils.isDark(context)?AppColors.blackColor:AppColors.mainColor;
    }

    SystemUiOverlayStyle _overlayStyle = brightness==null?ThemeData.estimateBrightnessForColor(_backgroundColor) == Brightness.dark
        ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark:(brightness==Brightness.dark?SystemUiOverlayStyle.dark: SystemUiOverlayStyle.light);

    var back = isBack ? IconButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ///是否是带参数返回
        if(backParameters!=null){
          AppPush.goBackWithParams(context, backParameters);
        }else if(isBackHome){//是否是返回主页
          AppPush.push(context, Routes.home);
        }else{
          AppPush.goBack(context);
        }
      },
      tooltip: 'Back',
      padding: const EdgeInsets.all(12.0),
      icon: Image.asset(
        backImg,
        color: AppColors.whiteColor,
      ),
    ) : Gaps.empty;

    var action = actionName.isNotEmpty ? Positioned(
      right: 0.0,
      child: Theme(
        data: Theme.of(context).copyWith(
            buttonTheme: ButtonThemeData(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              minWidth: 60.0,
            )
        ),
        child: FlatButton(
          child: Text(actionName, key: const Key('actionName')),
          textColor: AppColors.whiteColor,
          highlightColor: Colors.transparent,
          onPressed: onPressed,
        ),
      ),
    ) :Gaps.empty;

    var right = Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 16,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          rightWidget??Gaps.empty
        ],
      ),
    );

    var titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(
            title.isEmpty ? centerTitle : title,
            style: TextStyle(fontSize: Dimens.font_sp18,color: centerTitleColor)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              action,
              right,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
