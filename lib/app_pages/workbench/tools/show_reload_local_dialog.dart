
import 'package:flutter/material.dart';

import '../../../public_header.dart';


class ShowReloadLocalDialog extends StatelessWidget {

  final String title;
  final String content;
  final String sureText;

  const ShowReloadLocalDialog({
    Key key,
    this.title = '位置同步',
    this.content = '',
    this.sureText = '确定',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: 280.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 55.0,
                    width: 280.0,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0,color: AppColors.bgColor))
                    ),
                    child: Center(child: Text(title, style: TextStyles.getBlackBoldText(15))),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    height: 80,
                    alignment: Alignment.center,
                    child: RichText(
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        text: TextSpan(
                            style: TextStyles.blackAnd14,
                          children: [
                            TextSpan(
                              text: '当前位置:'
                            ),
                            TextSpan(
                                text: content,
                                style: TextStyle(fontSize: 14,color: AppColors.orangeColor)
                            ),
                            TextSpan(
                                text: '已与服务器同步完毕'
                            )
                          ]
                        )
                    ),
                  ),
                  Gaps.vGap10,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0 , top: 5.0),
                    child: Container(
                      height: 45,
                      child: AppButton(
                          title: sureText,
                          textStyle: TextStyle(fontSize: 14,color: AppColors.whiteColor),
                          bgColor: AppColors.mainColor,
                          radius: 36.0,
                          image: null,
                          onPress: (){
                            AppPush.goBack(context);
                          }
                      ),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }


}
