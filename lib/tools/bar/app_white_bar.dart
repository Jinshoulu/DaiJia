
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../public_header.dart';

import '../app_color.dart';


/// 自定义AppBar
class ShowWhiteAppBar extends StatelessWidget implements PreferredSizeWidget {

  ShowWhiteAppBar({
    Key key,
    this.backgroundColor,
    this.title = '',
    this.centerTitle = '',
    this.actionName = '',
    this.backImg = 'assets/images/ic_back_black.png',
    this.onPressed,
    this.rightWidget,
    this.isBack = true,
    this.isBackHome = false,
    this.parameters,
    this.isBackLogin = false,
    this.isReload = false,
  }): super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;
  final bool isReload;
  final Widget rightWidget;
  final bool isBackHome;
  final bool isBackLogin;
  var parameters;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = ThemeUtils.getBackgroundColor(context);
    } else {
      _backgroundColor = ThemeUtils.isDark(context)?AppColors.blackColor:AppColors.whiteColor;
    }

    SystemUiOverlayStyle _overlayStyle = ThemeData.estimateBrightnessForColor(_backgroundColor) == Brightness.dark
        ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    var back = isBack ? IconButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if(isBackHome){
          AppPush.push(context, Routes.home);
        }else{
          if(isBackLogin){
            AppPush.push(context, LoginRouter.loginPage);
          }else{
            if(isReload){
              AppPush.goBackWithParams(context, true);
            }else{
              if(parameters==null){
                AppPush.goBack(context);
              }else{
                AppPush.goBackWithParams(context, parameters);
              }
            }
          }
        }
      },
      tooltip: 'Back',
      padding: const EdgeInsets.all(12.0),
      icon: Image.asset(
        backImg,
        color: ThemeUtils.isDark(context) ? AppColors.whiteColor : AppColors.blackColor,
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
          textColor: ThemeUtils.isDark(context) ? AppColors.whiteColor : AppColors.blackColor,
          highlightColor: Colors.transparent,
          onPressed: onPressed,
        ),
      ),
    ) : Gaps.empty;

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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: Dimens.font_sp18,color: ThemeUtils.isDark(context)?AppColors.whiteColor:AppColors.blackColor)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: backgroundColor??_backgroundColor,
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
