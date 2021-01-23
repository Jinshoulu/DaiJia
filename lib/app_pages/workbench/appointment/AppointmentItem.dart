
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:flutter/material.dart';


class AppointmentItem extends StatefulWidget {

  final Map data;

  const AppointmentItem({Key key, this.data}) : super(key: key);

  @override
  _AppointmentItemState createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {


  StreamSubscription _subscription;
  int _second = 30;
  int _currentSecond = 30;

  Color onTheHandColor = AppColors.orangeColor;
  //状态
  int onTheHandStatus = 0;
  String title = '举手';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
  }

  //验证码倒计时
  startRunCode()async{
    _second = 30;
    _subscription = Stream.periodic(Duration(seconds: 1), (i) => i).take(_second).listen((i) {
      print(_currentSecond);
      if(mounted){
        setState(() {
          _currentSecond = _second - i - 1;
          if(_currentSecond<=0){
            _subscription?.cancel();
            onTheHandStatus = 2;
          }
        });
      }else{
        _subscription?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(onTheHandStatus){
      case 0:{
        onTheHandColor = AppColors.orangeColor;
        title = '举手';
      }break;
      case 1:{
        onTheHandColor = AppColors.red;
        title = '已举手(${_currentSecond}s)';
      }break;
      case 2:{
        onTheHandColor = AppColors.greenColor;
        title = '接单成功';
      }break;
      default:{
        onTheHandColor = AppColors.orangeColor;
        title = '已失效';
      }break;
    }
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.only(top: 16),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          AppCell(title: '预约时间:',height: 30.0, content: '2020.2.23 12:12'),
          AppCell(title: '目的地:',height: 30.0, content: '山东济南靖江公园'),
          AppCell(title: '预约里程:',height: 30.0, content: '846.16km'),
          AppCell(title: '预约人手机:',height: 30.0, content: '177777888'),
          SizedBox(height: 16.0,),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.bgColor,width: 1))
            ),
            height: 70.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: 90.0,
                  height: 40.0,
                  child: AppButton(title: '联系他',radius: 40.0,bgColor: AppColors.mainColor,textStyle: TextStyle(fontSize: 12,color: AppColors.whiteColor), onPress: (){

                    AppShowBottomDialog.showCallPhoneDialog('17752521882', context);

                  }),
                ),
                SizedBox(width: 20.0,),
                SizedBox(
                  width: 90.0,
                  height: 40.0,
                  child: AppButton(title: title,radius: 40.0,bgColor: onTheHandColor,textStyle: TextStyle(fontSize: 12,color: AppColors.whiteColor), onPress: (){
                      if(onTheHandStatus==0){
                        startRunCode();
                        setState(() {
                          onTheHandStatus = 1;
                        });
                      }
                  }),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}


