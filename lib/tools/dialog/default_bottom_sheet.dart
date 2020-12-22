import 'package:flutter/material.dart';

import '../../public_header.dart';

/// design/4商品/index.html#artboard2
class DefaultBottomSheet extends StatelessWidget {

  final Function onPress1;
  final Function onPress2;
  final String title1;
  final String title2;

  const DefaultBottomSheet({Key key,@required this.onPress1,@required this.onPress2, this.title1 = '相机', this.title2 = '相册'}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 54.0,
              width: double.infinity,
              child: FlatButton(
                textColor: Colors.black,
                child: Text(title1, style: TextStyle(fontSize: Dimens.font_sp14)),
                onPressed: () {
                  AppPush.goBack(context);
                  onPress1();
                },
              ),
            ),
            Gaps.line,
            SizedBox(
              height: 54.0,
              width: double.infinity,
              child: FlatButton(
                textColor: Colors.black,
                child: Text(title2, style: TextStyle(fontSize: Dimens.font_sp14)),
                onPressed: () {
                  AppPush.goBack(context);
                  onPress2();
                },
              ),
            ),
            Gaps.line,
            SizedBox(
              height: 54.0,
              width: double.infinity,
              child: FlatButton(
                textColor: AppColors.text_gray,
                child: const Text('取消', style: TextStyle(fontSize: Dimens.font_sp18)),
                onPressed: () {
                  AppPush.goBack(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}