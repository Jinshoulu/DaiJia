


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

class TextStyles {

  ///黑色14号
  static const TextStyle blackAnd14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.black
  );

  ///黑色12号
  static const TextStyle blackAnd12 = const TextStyle(
      fontSize: Dimens.font_sp12,
      color: Colors.black
  );

  ///白色14号
  static const TextStyle whiteAnd14 = const TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colors.white
  );

  ///白色12号
  static const TextStyle whiteAnd12 = const TextStyle(
      fontSize: Dimens.font_sp12,
      color: Colors.white
  );

  ///主题色14号
  static const TextStyle mainAnd14 = const TextStyle(
      fontSize: Dimens.font_sp14,
      color: AppColors.mainColor
  );
  ///主题色12号
  static const TextStyle mainAnd12 = const TextStyle(
      fontSize: Dimens.font_sp14,
      color: AppColors.mainColor
  );

  ///黑色加粗字体
  static getBlackBoldText(double fontSize){
    return TextStyle(
        fontSize: fontSize,
        color: Colors.black,
        fontWeight: FontWeight.bold
    );
  }

  ///黑色加粗字体
  static getWhiteBoldText(double fontSize){
    return TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.bold
    );
  }

  ///时间字体
  static const TextStyle timeStyle = const TextStyle(
      fontSize: Dimens.font_sp10,
      color: Colors.black26
  );

  ///夜间文字
  static const TextStyle textDark = const TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colors.white,
      textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle text = const TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colors.black,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic
  );


  static const TextStyle textGray12 = const TextStyle(
      fontSize: Dimens.font_sp12,
      color: AppColors.text_gray,
      fontWeight: FontWeight.normal
  );

  static const TextStyle textDarkGray12 = const TextStyle(
      fontSize: Dimens.font_sp12,
      color: AppColors.dark_text_gray,
      fontWeight: FontWeight.normal
  );

  static const TextStyle textDarkGray14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: AppColors.dark_text_gray,
  );

  static const TextStyle textHint14 = const TextStyle(
      fontSize: Dimens.font_sp14,
      color: AppColors.dark_unselected_item_color
  );

}