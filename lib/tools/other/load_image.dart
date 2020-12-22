
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:demo/tools/image/image_utils.dart';


/// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {

  const LoadImage(this.image, {
    Key key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.format = 'png',
    this.holderImg = 'defaultImage',
    this.radius = 8.0,
    this.localFile,
    this.borderRadius,
  }): super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final String holderImg;
  final double radius;
  final String localFile;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    if (TextUtil.isEmpty(image) || image == 'null') {
      return LoadAssetImage(holderImg,
        height: height,
        width: width,
        fit: fit,
        format: format,
        radius: radius,
      );
    } else {
      if (image.startsWith('http')) {
        return ClipRRect(
          borderRadius: borderRadius==null?BorderRadius.circular(radius):borderRadius,
          child: CachedNetworkImage(
            imageUrl: image,
            placeholder: (context, url) => localFile!=null?Image.file(File(localFile),height: height,fit: BoxFit.fitWidth,):LoadAssetImage(holderImg, height: height, width: width, fit: fit),
            errorWidget: (context, url, error) =>localFile!=null?Image.file(File(localFile),height: height,fit: BoxFit.fitWidth,):LoadAssetImage(holderImg, height: height, width: width, fit: fit),
            width: width,
            height: height,
            fit: fit,
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: LoadAssetImage(image,
            height: height,
            width: width,
            fit: fit,
            format: format,
            radius: radius,
          ),
        );
      }
    }
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {

  const LoadAssetImage(this.image, {
    Key key,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.fit = BoxFit.fill,
    this.format = 'png',
    this.color,
    this.radius = 8.0,
  }): super(key: key);

  final String image;
  final double width;
  final double height;
  final int cacheWidth;
  final int cacheHeight;
  final BoxFit fit;
  final String format;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Image.asset(
        ImageUtils.getImgPath(image, format: format),
        height: height,
        width: width,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        fit: fit,
        color: color,
        /// 忽略图片语义
        excludeFromSemantics: true,
      ),
    );
  }
}

