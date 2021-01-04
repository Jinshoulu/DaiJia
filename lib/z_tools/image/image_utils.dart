import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../public_header.dart';


class ImageUtils {

  static ImageProvider getAssetImage(String name, {String format = 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static ImageProvider getImageProvider(String imageUrl, {String holderImg = 'none'}) {
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(getImgPath(holderImg));
    }
    return CachedNetworkImageProvider(imageUrl);
  }
}


class Images {

  static const Widget arrowRight = const LoadAssetImage('ic_arrow_right', height: 15.0, width: 15.0,color: AppColors.blackColor,);

  static const Widget arrowRightWhite = const LoadAssetImage('ic_arrow_right', height: 15.0, width: 15.0, color: AppColors.whiteColor,);
}