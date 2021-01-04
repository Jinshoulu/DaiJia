
import 'package:demo/public_header.dart';
import 'package:flutter/material.dart';

class TopCenterMenu extends StatelessWidget {

  final Function onPress;

  const TopCenterMenu({Key key, @required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.0,
      child: Row(
        children: <Widget>[
          createExpand('首页-司机中心','司机中心', 0),
          createExpand('首页-任务中心','任务中心', 1),
          createExpand('首页-优推兑换','优推兑换', 2),
        ],
      ),
    );
  }

  createExpand(String image,String title,int index){
    return Expanded(
        child: AppButton(
            title: title,
            textStyle: TextStyles.blackAnd14,
            buttonType: ButtonType.upImage,
            image: image,
            imageSize: 40,
            onPress: (){
              onPress(index);
            }
        )
    );
  }
}
