
import 'package:flutter/material.dart';

import '../../public_header.dart';

class StoreSelectTextItem extends StatelessWidget {

  const StoreSelectTextItem({
    Key key,
    this.onTap,
    @required this.title,
    this.content = '',
    this.textAlign = TextAlign.start,
    this.style
  }): super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.only(right: 8.0, left: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
              bottom: Divider.createBorderSide(context, width: 0.6),
            )
        ),
        child: Row(
          children: <Widget>[
            Text('*',style: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.mainColor),),
            Text(title,style: TextStyles.blackAnd14,),
            Gaps.hGap16,
            Expanded(
              child: Text(
                  content,
                  maxLines: 2,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: style
              ),
            ),
            Gaps.hGap8,
            Images.arrowRight
          ],
        ),
      ),
    );
  }
}
