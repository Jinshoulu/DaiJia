
import 'package:demo/provider/user_info.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAddress extends StatelessWidget {
  final Function pushMap;
  final Function pushYuyue;

  const HomeAddress({Key key,@required this.pushMap,@required this.pushYuyue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      padding: EdgeInsets.only(left: 16,right: 16),
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 5,right: 10.0),
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: (){
                pushMap();
              },
              child: Container(
                width: 70.0,
                alignment: Alignment.center,
                child: LoadAssetImage('首页-地图',width: 35.0,fit: BoxFit.fitWidth,radius: 0.0,),
              ),
            ),
            Expanded(child: InkWell(
              onTap: (){
                pushMap();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextContainer(title: Provider.of<UserInfo>(context).user_aoi_name??'', height: 20, style: TextStyles.getBlackBoldText(15)),
                  Container(alignment: Alignment.centerLeft,child: Text(Provider.of<UserInfo>(context).user_local_address??'',style: TextStyle(fontSize: 12,color: AppColors.black54Color),),)
                ],
              ),
            )),
            AppButton(title: '预约大厅>',textStyle: TextStyle(fontSize: 14,color: AppColors.orangeColor), image: null, onPress:(){
              pushYuyue();
            })
          ],
        ),
      ),
    );
  }
}
