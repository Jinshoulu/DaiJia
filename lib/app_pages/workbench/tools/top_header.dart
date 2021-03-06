
import 'package:demo/app_pages/workbench/beans/HomeInfoBean.dart';
import 'package:demo/provider/app_status.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopHeader extends StatefulWidget {
  final HomeInfoBean bean;

  const TopHeader({Key key,@required this.bean}) : super(key: key);

  @override
  _TopHeaderState createState() => _TopHeaderState();
}

class _TopHeaderState extends State<TopHeader> {

  bool isConnect = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isConnect = Provider.of<AppStatus>(this.context,listen: false).connect??false;

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      color: AppColors.littleRed,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(width: 10,height: 10,decoration: BoxDecoration(color: widget.bean?.dstatus==2?AppColors.greenColor:AppColors.red,borderRadius: BorderRadius.all(Radius.circular(10.0))),),
          SizedBox(width: 10,),
          TextContainer(title: widget.bean?.dstatus==1?'下班':'上班', height: 45, style: TextStyles.blackAnd14),
          SizedBox(width: 10,),
          Icon(Icons.refresh,size: 20,color: Colors.black,),
        ],
      ),
    );
  }
}

