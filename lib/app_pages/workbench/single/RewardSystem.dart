
import 'package:demo/z_tools/app_widget/load_image.dart';
import 'package:demo/z_tools/bar/app_white_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../public_header.dart';

class RewardSystem extends StatefulWidget {
  @override
  _RewardSystemState createState() => _RewardSystemState();
}

class _RewardSystemState extends State<RewardSystem> {


  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    getData();
  }
  //读取缓存
  readData(){
    AppClass.readData(Api.homeGetRewordUrl).then((value){
      if(value!=null){
        setState(() {
          data = value;
        });
      }
    });
  }

  getData(){
    DioUtils.instance.post(Api.homeGetRewordUrl,onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.homeGetRewordUrl);
        if(mounted){
          setState(() {
            data = response;
          });
        }
      }
    },onFailure: (code,msg){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '奖励机制',
      ),
      body: Container(
        width: double.infinity,
        child: Html(data: data==null?'奖励机制':data['content']==null?'奖励机制':data['content']??''),
      ),
    );
  }
}
