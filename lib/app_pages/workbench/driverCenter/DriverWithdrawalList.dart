
import 'dart:math';

import 'package:demo/app_pages/workbench/driverCenter/DriverWithdralBean.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverWithdrawal.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_bus_event.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/image/image_header.dart';
import 'package:demo/z_tools/net/log_utils.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:demo/z_tools/save_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart';
import 'package:tobias/tobias.dart';

class DriverWithdrawalList extends StatefulWidget {
  @override
  _DriverWithdrawalListState createState() => _DriverWithdrawalListState();
}

class _DriverWithdrawalListState extends State<DriverWithdrawalList> {

  List dataList = [];

  StreamSubscription<BaseWeChatResponse> mBaseWeChatResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mBaseWeChatResponse =
        weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) {
          if (res != null && res is WeChatAuthResponse) {
            if (mounted) {
              setState(() {
                Log.e("state :${res.state} \n code:${res.code}");
                if(res?.isSuccessful??false){
                  requestThirdth(res.code, '2');
                }else{
                  Toast.show("获取微信code失败！");
                }
              });
            }
          }
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '提现账号',
        rightWidget: AppButton(
            title: '添加账号',
            onPress: (){
              AppShowBottomDialog.showBottomListSheet(context, '添加提现账号', ['支付宝','微信'], (int index){
                switch(index){
                  case 0:{//支付宝
                    getAlipayConfig();
                  }break;
                  case 1:{//微信
                    authToWechat(context);
                  }break;
                  default:{}break;
                }
              });
            }
        ),
      ),
      body: AppRefreshWidget(
          requestData: {},
          requestUrl: Api.withdrawAccountListUrl,
          saveValue: Api.withdrawAccountListUrl,
          requestBackData: (List list){
            if(mounted){
              setState(() {
                dataList = list;
              });
            }
          },
          itemBuilder: (BuildContext context,int index){
            return createContainer(dataList[index]);
          }

      ),
    );
  }

  createContainer(data){

    DriverWithdralBean bean = DriverWithdralBean.fromJson(data);

    return InkWell(
      onTap: (){
        AppPush.pushDefault(this.context, DriverWithdrawal(
          idStr: bean?.id.toString()??'',
        ));
      },
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Row(
          children: <Widget>[
            ImageHeader(
                image: bean.headimg??''
            ),
            SizedBox(width: 10.0,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextContainer(title: bean.nickname??'', height: 30.0, style: TextStyle(fontSize: 14,)),
//                    TextContainer(title: '授权时间: ${bean.}', height: 20.0, style: TextStyle(fontSize: 14,))
                  ],
                )
            ),
            Container(
              child: AppText(text: bean.msg??''),
            )
          ],
        ),
      ),
    );
  }

  void authToWechat(BuildContext context) async {
    sendWeChatAuth(scope: "snsapi_userinfo", state: "flutter_dai_jia")
        .then((data) {
      print('获取Code成功......... ${data}');
    });
  }

  getAlipayConfig(){
    DioUtils.instance.post(Api.withdrawInfoStrUrl,onSucceed: (response){
      if(response is Map){
        if(response['infostr']!=null){
          startRequestAlipay(response['infostr'].toString());
        }
      }
    },onFailure: (code,msg){

    });
  }

  getAlipayCode(String appid,String pid)async{
    String alipay_url = "https://openauth.alipay.com/oauth2/appToAppAuth.htm?app_id=$appid'&redirect_uri=http%3A%2F%2Fexample.com";

    DioUtils.instance.get(alipay_url,onSucceed: (response){

    }, onFailure: (code,msg){

    });


  }

  startRequestAlipay(String auth)async{
    isAliPayInstalled().then((data)async{
      print("installed $data");
      try {
        var payResult = await aliPayAuth(auth);
        //{resultStatus: 6001, result: , memo: 支付未完成。}
        debugPrint("alipay auth--->$payResult");
        if(payResult['resultStatus'] != null){

          String status = payResult['resultStatus'].toString();
          switch(status){
            case '9000':{
              String result = payResult['result'].toString();
              List list = result.split('&');
              if(list.length>4){
                String code = list[3];
                List codeList = code.split('=');
                if(codeList.length>1){
                  String authCode = codeList.last;
                  requestThirdth(authCode, '1');
                }
              }
            }break;
            default:{
              Toast.show(payResult['memo'].toString());
            }break;
          }
        }

      } on Exception catch (e) {
        Toast.show(e.toString());
      }
    });
  }
  
  requestThirdth(String code,String type){
    
    DioUtils.instance.post(Api.withdrawThridthUrl,data: {'code':code,'type':type},onSucceed: (response){
      eventBus.fire(ReloadListPage());
    },onFailure: (code,msg){

    });
  }
}
