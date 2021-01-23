
import 'package:demo/app_pages/mine/bean/SpotCheckBean.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_add_images_widget.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:flutter/material.dart';

class SpotCheckItem extends StatefulWidget {

  final Function submitResult;
  final SpotCheckBean bean;

  const SpotCheckItem({
    Key key,
    @required this.submitResult,
    @required this.bean
  }) : super(key: key);

  @override
  _SpotCheckItemState createState() => _SpotCheckItemState();
}

class _SpotCheckItemState extends State<SpotCheckItem> {

  List images = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          ContainerAddLineWidget(
              child: AppCell(
                title: '抽检时间: 2021-12-12 12:12',
                content: '确认上传',
                contentStyle: TextStyle(fontSize: 14,color: AppColors.orangeColor),
              )
          ),
          SizedBox(height: 20.0,),
          AppAddImageWidget(
              maxCount: 2,
              imageFiles: (List list){
                images = list;
              }
          ),
          SizedBox(height: 20.0,),
        ],
      ),
    );
  }

  submitSpotResult(){

    var data = {
      'id':widget.bean?.id,
      'fileurls':images
    };
    
    DioUtils.instance.post(Api.mineSubmitSpotCheckRecordUrl,data: data,onFailure: (code,msg){

    },onSucceed: (response){
      widget.submitResult();
    });

  }
}
