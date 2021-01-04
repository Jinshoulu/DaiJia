
import 'package:demo/z_tools/app_widget/my_separator.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class PushQrCode extends StatefulWidget {
  @override
  _PushQrCodeState createState() => _PushQrCodeState();
}

class _PushQrCodeState extends State<PushQrCode> {
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
                title: Text('推广代叫商家'),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-60.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60,),
                      Expanded(child: Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(child: LoadAssetImage('推广卡片',radius: 0.0,)),
                            Positioned.fill(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 80,),
                                Expanded(child: Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: LoadAssetImage('defaultImage',radius: 0.0,),
                                )),
                                SizedBox(height: 30,),
                                SizedBox(
                                  width: double.infinity,
                                  height: 1,
                                  child: MySeparator(),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(left: 30,right: 30),
                                  height: 80.0,
                                  child: RichText(textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 3,text: TextSpan(
                                      style: TextStyle(fontSize: 14,color: AppColors.black54Color),
                                      children: [
                                        TextSpan(
                                            text: '代叫上架扫此码注册为代叫商家后,每成功代叫1单,您即可得'
                                        ),
                                        TextSpan(
                                            text: '10',
                                            style: TextStyle(fontSize: 15,color: AppColors.orangeColor)
                                        ),
                                        TextSpan(
                                            text: '积分'
                                        )
                                      ]
                                  )),
                                )
                              ],
                            )),
                            Positioned(top: 0,left: 0,right: 0,child: Container(
                              height: 50.0,
                              alignment: Alignment.center,
                              child: Text('梅超风的代叫推广码',style: TextStyles.getWhiteBoldText(15)),
                            ))
                          ],
                        ),
                      )),
                      SizedBox(height: 120.0,)
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
