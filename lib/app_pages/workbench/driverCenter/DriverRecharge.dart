
import 'package:demo/app_pages/workbench/beans/RechargeBean.dart';
import 'package:demo/provider/user_info.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverRecharge extends StatefulWidget {
  @override
  _DriverRechargeState createState() => _DriverRechargeState();
}

class _DriverRechargeState extends State<DriverRecharge> {


  TextEditingController _editingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  int selectIndex = 0;
  List images = ['充值-支付宝','充值-微信','充值-银联'];
  List titles = ['支付宝','微信支付','银联支付'];

  int  selectMoneyIndex = 0;
  RechargeBean _rechargeBean;
  List<Data> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    getData();
  }

  //获取数据
  getData(){
    DioUtils.instance.post(Api.orderRechargePackageUrl, onFailure: (code,msg){

    },onSucceed: (response){
        if(response is Map){
          AppClass.saveData(response, Api.orderRechargePackageUrl);
          reloadState(response);
        }
    });
  }

  //读取缓存
  readData(){
    AppClass.readData(Api.orderRechargePackageUrl).then((value){
      if(value!=null){
       reloadState(value);
      }
    });
  }

  reloadState(data){
    if(mounted){
      setState(() {
        _rechargeBean = RechargeBean.fromJson(data);
        _list = _rechargeBean.list;
        if(_list.length>0){
          _editingController.text = _list[selectMoneyIndex].money;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActionWidget(
        list: [_focusNode],
        child: Scaffold(
          backgroundColor: AppColors.lightBlueColor,
          body: CustomScrollView(
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
                title: Text('账户充值'),
                centerTitle: true,
                floating: false,
                pinned: true,
                snap: false,
                expandedHeight: MediaQuery.of(context).size.width-30,
                flexibleSpace: new FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Positioned(left: 0,top: 0,right: 0,bottom: 150.0,child: LoadAssetImage('账户充值背景',format: 'jpg',radius: 0.0,)),
                      Positioned(
                          top: MediaQuery.of(context).padding.top+48.0+20.0,
                          left: 16,
                          right: 16,
                          bottom: 0,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 30.0,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 120.0,
                                        child: AppText(
                                          alignment: Alignment.centerLeft,
                                          text: '充值账号',color: AppColors.whiteColor,),),
                                      Expanded(child: AppText(text: '余额: ${Provider.of<UserInfo>(context).money??''}元',color: AppColors.whiteColor,alignment: Alignment.centerRight,),)
                                    ],
                                  ),
                                ),
                                TextContainer(title: Provider.of<UserInfo>(context).phone??'', height: 40.0, style: TextStyles.getWhiteBoldText(30)),
                                Expanded(child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: Card(
                                    elevation: 4.0,
                                    shadowColor: AppColors.lightBlueColor,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                          color: AppColors.whiteColor),
                                      child: Column(
                                        children: <Widget>[
                                          ContainerAddLineWidget(
                                              child: Container(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    SizedBox(width: 80.0,child: AppText(text: '充值金额'),),
                                                    Expanded(
                                                      child: Container(
                                                        child: TextField(
                                                          controller: _editingController,
                                                          focusNode: _focusNode,
                                                          keyboardType: TextInputType.number,
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontSize: 20,color: AppColors.mainColor),
                                                          inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
                                                          decoration: InputDecoration(
                                                            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                                                            hintText: '充值金额',
                                                            hintStyle: TextStyle(color: AppColors.black54Color,fontSize: 14),
                                                            counterText: '',
                                                            border: new OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                            ),
                                                          ),
                                                          onSubmitted: (value){
                                                            _focusNode.unfocus();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 30.0,child: AppText(text: '元',color: AppColors.mainColor,),)
                                                  ],
                                                ),
                                              )
                                          ),
                                          _list.isEmpty?SizedBox():Expanded(
                                              child:Padding(
                                                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                child: GridView.builder(
                                                    padding: EdgeInsets.all(0.0),
                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 10.0,
                                                        childAspectRatio: 2.5,
                                                        mainAxisSpacing: 10.0
                                                    ),
                                                    itemBuilder: (BuildContext context,int index){
                                                      return InkWell(
                                                        onTap: (){
                                                          setState(() {
                                                            selectMoneyIndex = index;
                                                            _editingController.text = _list[selectMoneyIndex].money;
                                                          });
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: selectMoneyIndex==index?AppColors.mainColor:AppColors.whiteColor,
                                                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                              border: Border.all(color: AppColors.mainColor,width: 1)
                                                          ),
                                                          child: Text('${_rechargeBean.list[index].money??''}元',style: TextStyle(fontSize: 15,color: selectMoneyIndex==index?AppColors.whiteColor:AppColors.mainColor),),
                                                        ),
                                                      );
                                                    },itemCount: _rechargeBean?.list?.length,
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: TextContainer(title: '支付方式', height: 50.0, style: TextStyles.blackAnd14),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 120.0,
                  child: Row(
                    children: <Widget>[
                      createItem(0),
                      createItem(1),
//                      createItem(2),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 30,),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: SizedBox(
                    height: 50.0,
                    child: AppButton(title: '去支付',bgColor: AppColors.mainColor,radius: 50.0,textStyle: TextStyles.whiteAnd14, onPress: (){

                    }),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  createItem(int index){

    return Expanded(
        child: InkWell(
          onTap: (){
            setState(() {
              selectIndex = index;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadAssetImage(images[index],width: 45,height: 45,radius: 0.0,),
              TextContainer(title: titles[index],alignment: Alignment.center, height: 30.0, style: TextStyles.blackAnd14),
              LoadAssetImage(selectIndex==index?'选择2':'选择1',width: 15,height: 15,radius: 0.0,),
            ],
          ),
        )
    );
  }

  //生成充值订单
  createRechargeOrder(){
    if(_editingController.text.isEmpty){
      Toast.show('充值金额不能为空');
      return;
    }
    //1.支付宝 2.微信
    var data = {
      'money': _editingController.text,
      'payment':selectIndex+1
    };
    DioUtils.instance.post(Api.orderCreateUrl,data: data,onSucceed: (response){

    },onFailure: (code,msg){

    });

  }
}
