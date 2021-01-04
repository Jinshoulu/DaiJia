import 'package:connectivity/connectivity.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/res/date_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../public_header.dart';

class DetermineWorkingStatus extends StatefulWidget {
  @override
  _DetermineWorkingStatusState createState() => _DetermineWorkingStatusState();
}

class _DetermineWorkingStatusState extends State<DetermineWorkingStatus> {

  String key = 'determineTime';

  bool loading = true;
  List<StatusModel> dataList = [];
  String determineTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isToday();
    determineStatus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SpUtil.putString(key, DateTime.now().millisecondsSinceEpoch.toString());
  }


  ///检测状态
  determineStatus()async{

    dataList.clear();
    await Permission.location.request().then((value){
      if(value.isGranted){
        dataList.add(StatusModel('定位正常', '您的GPS开启正常',true));
      }else{
        dataList.add(StatusModel('定位异常', '您的GPS开启异常',false));
      }
    });

    await Permission.camera.request().then((value){
      if(value.isGranted){
        dataList.add(StatusModel('摄像头正常', '摄像头权限已申请',true));
      }else{
        dataList.add(StatusModel('摄像头开启异常', '摄像头权限被拒绝',false));
      }
    });

    await Permission.microphone.request().then((value){
      if(value.isGranted){
        dataList.add(StatusModel('麦克风正常', '麦克风权限已申请',true));
      }else{
        dataList.add(StatusModel('麦克风异常', '麦克风权限被拒绝',false));
      }
    });

    ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.mobile||result==ConnectivityResult.wifi){
      dataList.add(StatusModel('网络正常', '当前网络链接正常',true));
    }else{
      dataList.add(StatusModel('网络异常', '当前网络链接失败,请检查网络',false));
    }

    Future.delayed(Duration(seconds: 3)).then((value){
      setState(() {

        loading = false;
      });
    });
  }

  isToday(){
    if(SpUtil.getString(key,defValue: '').isNotEmpty){
      if(DateUtil.isToday(int.parse(SpUtil.getString(key,defValue: '')))){
        DateTime time = DateTime.fromMillisecondsSinceEpoch(int.parse(SpUtil.getString(key)));
        determineTime = '${time.hour.toString()}:${time.minute.toString()}';
      }else{
        DateTime time = DateTime.fromMillisecondsSinceEpoch(int.parse(SpUtil.getString(key)));
        determineTime = '${time.month.toString()}-${time.day.toString()}';;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 52.0,
              child: Center(
                child: Text(
                  '工作状态检查',
                  style: TextStyle(fontSize: Dimens.font_sp14,color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 0.6,
              width: double.infinity,
              child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.black54Color)),
            ),
            loading?Container(
              height: 250,
              alignment: Alignment.center,
              child: const CupertinoActivityIndicator(radius: 16.0),
            ):createSub(),
            SizedBox(height: 30.0,),
            Container(
              height: 70.0,
              padding: EdgeInsets.only(left: 16,right: 16),
              alignment: Alignment.center,
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: AppButton(
                  bgColor: AppColors.mainColor,
                    radius: 45,
                    title: '重新检查',
                    textStyle: TextStyles.whiteAnd14,
                    image: null,
                    onPress: (){
                      setState(() {
                        loading = true;
                      });
                      determineStatus();
                    }),
              ),
            ),

            determineTime==null?SizedBox():TextContainer(
                alignment: Alignment.center,
                title:'上次检查: ${determineTime}',
                height: 40,
                style: TextStyle(
                    fontSize: 12,color: AppColors.orangeColor)),
            SizedBox(height: 30.0,)
          ],
        ),
      ),
    );
  }

  createSub(){

    List<Widget> list = List.generate(dataList.length, (index){
      StatusModel model = dataList[index];
      return ContainerAddLineWidget(
        height: 60,
        disW: 0.0,
          edgeInsets: EdgeInsets.all(0),
          child: Container(
            padding: EdgeInsets.only(top: 5,bottom: 5, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      model.name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: model.success?AppColors.blackColor:AppColors.red
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model.content,
                    style: TextStyle(
                        fontSize: 12,
                        color: model.success?AppColors.blackColor:AppColors.red
                    ),
                  ),
                ))
              ],
            ),
          )
      );
    });

    return Container(
      child: Column(
        children: list,
      ),
    );
  }
}


class StatusModel {

  final String name;
  final String content;
  final bool success;
  StatusModel(this.name, this.content, this.success);
}