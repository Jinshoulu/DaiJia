
import 'package:demo/app_pages/mine/bean/AdmentDertailBean.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MineAdmentDetail extends StatefulWidget {

  final String id;

  const MineAdmentDetail({Key key,@required this.id}) : super(key: key);

  @override
  _MineAdmentDetailState createState() => _MineAdmentDetailState();
}

class _MineAdmentDetailState extends State<MineAdmentDetail> {

  Timer _timer;
  ///剩余时间
  int seconds = 1000;
  ///学习时间
  int allSecond = 1000;

  AdmentDetailBean detailBean;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    _timer = null;
    if(detailBean?.status!=1){
      submitCurrentLearnProgress();
    }

  }

  /// 获取公告详情
  getData(){


  }

  ///提交学习进度
  submitCurrentLearnProgress(){

    var data = {
      'id':widget.id,
      'seconds':allSecond-seconds
    };
    DioUtils.instance.post(Api.baseApi,data: data,onFailure: (code,msg){

    },onSucceed: (response){

    });

  }


  startTimer(){
    if(_timer==null){
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        seconds--;
        if(seconds<0){
          _timer?.cancel();
          _timer = null;
        }
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: detailBean?.title??'公告详情',
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Html(
                  data: detailBean?.title??''
              )
          ),
          Positioned(
              top: 0,
              bottom: 0,
              right: 10,
              child: Container(
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      alignment: Alignment.center,
                      child: AppText(text: AppClass.secondChangeTime(seconds),color: AppColors.mainColor,),
                    ),
                    Container(
                      height: 20.0,
                      alignment: Alignment.center,
                      child: LoadAssetImage('公告-学习闹钟',height: 20,fit: BoxFit.fitHeight,radius: 0.0,),
                    )
                  ],
                ),
              )
          ),

        ],
      ),
    );
  }

}
