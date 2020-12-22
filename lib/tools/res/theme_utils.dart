import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_color.dart';
import '../res/device_utils.dart';


class ThemeUtils {

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getDarkColor(BuildContext context, Color darkColor) {
    return isDark(context) ? darkColor : null;
  }

  static Color getIconColor(BuildContext context) {
    return isDark(context) ? Colors.black : Colors.white;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color getDialogBackgroundColor(BuildContext context) {
    return Theme.of(context).canvasColor;
  }

  static Color getStickyHeaderColor(BuildContext context) {
    return isDark(context) ? AppColors.dark_bg_gray_ : AppColors.bg_gray_;
  }

  static Color getDialogTextFieldColor(BuildContext context) {
    return isDark(context) ? AppColors.dark_bg_gray_ : AppColors.bg_gray_;
  }

  static Color getKeyboardActionsColor(BuildContext context) {
    return isDark(context) ? AppColors.dark_bgColor : Colors.grey[200];
  }

  /// 设置NavigationBar样式
  static void setSystemNavigationBarStyle(BuildContext context, ThemeMode mode) {
    /// 仅针对安卓
    if (Device.isAndroid) {
      bool _isDark = false;
      final ui.Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);
      print(platformBrightness);
      if (mode == ThemeMode.dark || (mode == ThemeMode.system && platformBrightness == ui.Brightness.dark)) {
        _isDark = true;
      }
      print(_isDark);
      var systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: _isDark ? AppColors.dark_bgColor : Colors.white,
        systemNavigationBarIconBrightness: _isDark ? Brightness.light : Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}