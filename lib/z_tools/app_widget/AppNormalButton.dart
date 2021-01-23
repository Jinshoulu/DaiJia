
import 'package:flutter/material.dart';

import '../../public_header.dart';

class AppNormalButton extends StatelessWidget {
  final double height;
  final String title;
  final Function onPress;

  const AppNormalButton({
    Key key,
    @required this.title,
    @required this.onPress,
    this.height = 50.0

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: SizedBox(
          height: 45.0,
          child: AppButton(
              radius: 45.0,
              title: title,
              textStyle: TextStyles.whiteAnd14,
              bgColor: AppColors.mainColor,
              onPress: (){
                onPress();
              }
          ),
        ),
      ),
    );
  }
}
