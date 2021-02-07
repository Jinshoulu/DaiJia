
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:demo/app_pages/login/ModifyPassword.dart';
import 'package:demo/app_pages/login/password_page.dart';
import 'package:demo/app_pages/mine/MineAbout.dart';
import 'package:demo/app_pages/mine/MineAddOrder.dart';
import 'package:demo/app_pages/mine/MineAdment.dart';
import 'package:demo/app_pages/mine/MineChargeStandard.dart';
import 'package:demo/app_pages/mine/MineCompleteInfo.dart';
import 'package:demo/app_pages/mine/MineDriverClass.dart';
import 'package:demo/app_pages/mine/MineFamilyNumber.dart';
import 'package:demo/app_pages/mine/MineOrder.dart';
import 'package:demo/app_pages/mine/MineSpotCheck.dart';
import 'package:demo/app_pages/mine/MineWorkingPage.dart';
import 'package:demo/app_pages/mine/bean/CustomerPhoneBean.dart';
import 'package:demo/app_pages/mine/tools/MineHeader.dart';
import 'package:demo/app_pages/mine/tools/MineService.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverRecharge.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_color.dart';
import 'package:demo/z_tools/app_widget/app_button.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/dialog/customer_service_dialog.dart';
import 'package:demo/z_tools/dialog/update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {


  CustomerPhoneBean phoneBean;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReadData();
    getCustomerPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: MineHeader(),
          ),
          SliverToBoxAdapter(
            child: AppCell(title: '我的服务',titleStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), content: ''),
          ),
          MineService(onPress: (String value){
           clickPushPage(value);
          },),
          SliverToBoxAdapter(
            child: AppCell(title: '其他服务',titleStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), content: ''),
          ),
          MineOtherService(onPress: (String value){
            clickPushPage(value);
          },),
          SliverToBoxAdapter(
            child: Container(
              height: 100.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 16,right: 16),
              child: SizedBox(
                height: 45.0,
                child: AppButton(bgColor: AppColors.mainColor,radius: 45.0,title: '退出登录',textStyle: TextStyles.whiteAnd14, onPress: (){
                  AppShowBottomDialog.showExit(context);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  clickPushPage(String value){

    switch (value){
      case '账户充值':{
          AppPush.pushDefault(this.context, DriverRecharge());
      }break;
      case '司机学堂':{
        AppPush.pushDefault(this.context, MineDriverClass());
      }break;
      case '我的订单':{
        AppPush.pushDefault(this.context, MineOrder());
      }break;
      case '电子工牌':{
        AppPush.pushDefault(this.context, MineWorkingPage());
      }break;
      case '抽检列表':{
        AppPush.pushDefault(this.context, MineSpotCheck());
      }break;
      case '收费标准':{
        AppPush.pushDefault(this.context, MineChargeStandard());
      }break;
      case '离线地图':{
        AmapService.instance.openOfflineMapManager();
      }break;
      case '修改密码':{
          AppPush.pushDefault(this.context, ModifyPassword());
      }break;
      case '公告列表':{
        AppPush.pushDefault(this.context, MineAdment());
      }break;
      case '亲情号码':{
        AppPush.pushDefault(this.context, MineFamily());
      }break;
      case '人工补单':{
        AppPush.pushDefault(this.context, MineAddOrder());
      }break;
      case '服务协议':{
          AppClass.readData(Api.drivingDelegateUrl).then((value) {
            if (value != null) {
              AppShowBottomDialog.showDelegateSheetDialog(this.context, '司机服务协议',AppClass.data(value, 'content'), '我知道了', () {});
            } else {

              getDriverDelegate();
            }
          });
      }break;
      case '订单问题':{
        showCustomerServiceDialog();
      }break;
      case '资料上传':{
        AppPush.pushDefault(this.context, MineCompleteInfo());
      }break;
      case '其他问题':{
        showLocalSiguanServiceDialog();
      }break;
      case '版本检查':{
        UpdateApp.determineAppVersion(this.context, false);
      }break;
      case '关于我们':{
        AppPush.pushDefault(this.context, MineAbout());
      }break;
      default:{}break;
    }
  }

  //获取最新数据
  getCustomerPhone(){

    DioUtils.instance.post(Api.mineCustomerPhonesUrl,onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.mineCustomerPhonesUrl);
        phoneBean = CustomerPhoneBean.fromJson(response);
      }
    },onFailure: (code,msg){

    });

  }

  //司机协议
  getDriverDelegate(){

    DioUtils.instance.post(Api.drivingDelegateUrl,onSucceed: (response){
      if(response is Map){
        AppClass.saveData(response, Api.drivingDelegateUrl);
        AppShowBottomDialog.showDelegateSheetDialog(this.context, '司机服务协议',AppClass.data(response, 'content'), '我知道了', () {});
      }else{
        Toast.show('返回格式错误,请联系服务端');
      }
    },onFailure: (code,msg){

    });

  }

  //获取保存数据
  getReadData(){
    AppClass.readData(Api.mineCustomerPhonesUrl).then((value){
      if(value!=null){
        setState(() {
          phoneBean = CustomerPhoneBean.fromJson(value);
        });
      }
    });
  }



  showCustomerServiceDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomerServiceDialog(
              isHiddenCancel: true,
              surePress: (){

              },
              content: '联系客服',
              title: '联系客服',
              phones: [phoneBean?.kefu_phone??''],
          );
        });
  }

  showLocalSiguanServiceDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomerServiceDialog(
            isHiddenCancel: true,
            surePress: (){

            },
            content: '本地司管',
            title: '联系本地司管',
            phones: phoneBean?.siguan_phone??[],
          );
        });
  }

}
