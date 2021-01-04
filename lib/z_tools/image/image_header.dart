
import 'package:demo/z_tools/app_widget/load_image.dart';
import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {

  final double height;
  final String image;

  const ImageHeader({
    Key key,
    this.height = 50.0,
    @required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(height)),
      child: Container(
        child: image.contains('http')
            ?LoadImage(image,width: height, height: height,radius: height,)
            :LoadAssetImage(image,width: height, height: height,radius: height,),
      ),
    );
  }
}
