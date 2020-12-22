
import 'package:flutter/material.dart';

import '../../public_header.dart';


class ImageItem extends StatelessWidget {

  final String image;
  final double imageSize;
  final double width;
  final double height;
  final Function onPress;

  const ImageItem({
    Key key,
    this.imageSize = 15,
    this.width = 40,
    this.height = 40,
    @required this.onPress,
    @required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPress();
      },
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: LoadAssetImage(image,width: imageSize,height: imageSize,radius: 0.0,),
      ),
    );
  }
}
