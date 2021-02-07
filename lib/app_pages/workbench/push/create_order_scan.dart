
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/bar/app_transparent_bar.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class CreateOrderScan extends StatefulWidget {
  @override
  _CreateOrderScanState createState() => _CreateOrderScanState();
}

class _CreateOrderScanState extends State<CreateOrderScan> {

  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData(){
    DioUtils.instance.post(Api.homeAppletQRCodeUrl,onSucceed: (response){
      if(response is Map){
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoadAssetImage('推广背景',format: 'jpg',radius: 0.0,),
          CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: AppColors.transparentColor,
                leading: IconButton(
                  onPressed: () {
                    AppPush.goBack(context);
                  },
                  tooltip: 'Back',
                  padding: const EdgeInsets.all(12.0),
                  icon: LoadAssetImage('back_black',width: 25,height: 25,radius: 0.0,color: AppColors.whiteColor,),
                ) ,
                title: Text('扫码下单'),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-60.0,
                  padding: EdgeInsets.only(left: 30,right: 30,bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40.0,),
                      Container(
                        alignment: Alignment.center,
                        child: LoadAssetImage('微信扫码',fit: BoxFit.fitWidth,radius: 0.0,),
                      ),
                      SizedBox(height: 40.0,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            color: ColorsApp.whiteColor,
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30.0,),
                              Expanded(child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: LoadImage(AppClass.data(data, 'code')),
                              )),
                              SizedBox(height: 20,),
                              TextContainer(alignment: Alignment.center,title: '使用微信', height: 30.0, style: TextStyles.blackAnd14),
                              TextContainer(
                                  alignment: Alignment.center,
                                  title: '扫描上面的二维码',
                                  height: 30.0,
                                  style: TextStyle(fontSize: 13,color: AppColors.black54Color)),
                              SizedBox(height: 30.0,)

                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 70.0,
                        child: Text(
                          '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.orangeColor
                          ),),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );

  }
}
