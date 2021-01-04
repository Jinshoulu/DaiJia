import 'package:demo/provider/app_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public_header.dart';

class CustomSlider extends StatefulWidget {

  final Function successCallBack;
  final Color positiveColor;
  final Color negetiveColor;
  final double totalWidth;
  final double height;

  const CustomSlider({
    Key key,
    this.positiveColor = AppColors.mainColor,
    this.negetiveColor = AppColors.lightBlueColor,
    @required this.totalWidth,
    @required this.height,
    @required this.successCallBack,
  }) : super(key: key);



  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {

  double progress = 0.0;
  String title = '右划开始接单';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.totalWidth,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.negetiveColor,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: Provider.of<AppStatus>(context).orderStatus==0?50:0),
            alignment: Alignment.center,
            child: Text(Provider.of<AppStatus>(context).orderStatus==0?'右划开始接单':'正在接单',style: TextStyle(fontSize: 14,color: AppColors.mainColor),),
          ),
          Provider.of<AppStatus>(context).orderStatus==0?Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: widget.positiveColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                width: progress * (widget.totalWidth-80)+80,
                alignment: Alignment.centerRight,
                child: LoadAssetImage('首页-滑动按钮',height: 50,width: 80,),
              ),
            ],
          ):Container(
            alignment: Alignment.center,
            child: CupertinoActivityIndicator(radius: 16.0),
          ),
          Provider.of<AppStatus>(context).orderStatus==0?Container(
            width: double.infinity,
            height: 50.0,
            child: Slider(
                value: progress,
                activeColor: AppColors.transparentColor,
                inactiveColor: AppColors.transparentColor,
                onChanged: (value){
                  print(value);
                  setState(() {
                    progress = value;
                    if(progress==1.0){
                      Provider.of<AppStatus>(context,listen: false).orderStatus=1;
                      progress=0.0;
                      widget.successCallBack();
                    }
                  });
                }
            ),
          ):SizedBox()
        ],
      ),
    );
  }
}