
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../public_header.dart';

class StategoesToMakeMoney extends StatefulWidget {
  @override
  _StategoesToMakeMoneyState createState() => _StategoesToMakeMoneyState();
}

class _StategoesToMakeMoneyState extends State<StategoesToMakeMoney> {



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
    AppClass.readData(Api.homeGetStrategyUrl).then((value){
      if(value!=null){
        setState(() {
          data = value;
        });
      }
    });
  }

  getData(){
    DioUtils.instance.post(Api.homeGetStrategyUrl,onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.homeGetStrategyUrl);
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
        centerTitle: '赚钱攻略',
      ),
      body: Container(
        width: double.infinity,
        child: Html(data: data==null?'奖励机制':data['content']==null?'奖励机制':data['content']??''),
      ),
    );
  }
}
