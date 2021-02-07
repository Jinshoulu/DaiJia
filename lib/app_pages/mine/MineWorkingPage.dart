
import 'package:demo/provider/user_info.dart';
import 'package:demo/z_tools/app_widget/AppBoldText.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/my_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../public_header.dart';

class MineWorkingPage extends StatefulWidget {
  @override
  _MineWorkingPageState createState() => _MineWorkingPageState();
}

class _MineWorkingPageState extends State<MineWorkingPage> {

  /// 是否正在加载数据
  bool _isLoading = true;
  var codeData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    getData();
  }

  //读取缓存
  readData(){
    AppClass.readData(Api.mineCodeCardUrl).then((value){
      if(value!=null){
        setState(() {
          codeData = value;
        });
      }
    });
  }

  //获取最新信息
  getData(){
    DioUtils.instance.post(Api.mineCodeCardUrl, onFailure: (code,msg){
      reloadState();
    },onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.mineCodeCardUrl);
        codeData = response;
        reloadState();
      }else{
        reloadState();
      }
    });
  }
  reloadState(){
    if(mounted){
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '电子工牌',
        rightWidget: AppButton(
            title: '平安到家',
            textStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),
            onPress: (){

            }
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoadAssetImage('电子工牌背景',radius: 0.0,),
          Container(
            margin: EdgeInsets.only(left: 30,right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 80.0,
                        child: AppBoldText(text: '标兵代驾',fonSize: 20.0,),
                      ),
                      Container(
                        height: 150.0,
                        child: LoadImage(AppClass.data(codeData, 'codes'),radius: 0.0,fit: BoxFit.fitHeight,),
                      ),
                      SizedBox(height: 30.0,),
                      SizedBox(
                        width: double.infinity,
                        height: 1,
                        child: MySeparator(),//绘制虚线
                      ),
                      Container(
                        height: 120.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: MediaQuery.of(context).size.width/2.0-30.0-80.0,),
                            Container(
                              width: 80.0,
                              height: 80.0,
                              alignment: Alignment.center,
                              child: LoadImage(Provider.of<UserInfo>(context).headimage??'',radius: 0.0,),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 30.0,
                                    child: AppBoldText(text: Provider.of<UserInfo>(context).nickname??'',alignment: Alignment.centerLeft,),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                    child: AppText(text: '工号: ${Provider.of<UserInfo>(context).code??''}',alignment: Alignment.centerLeft,),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                    child: AppText(text: '驾龄: ${Provider.of<UserInfo>(context).work_time??''}年',alignment: Alignment.centerLeft,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
