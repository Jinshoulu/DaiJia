
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_add_images_widget.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class DriverWithdrawal extends StatefulWidget {

  final String idStr;
  const DriverWithdrawal({
    Key key,
    @required this.idStr
  }) : super(key: key);


  @override
  _DriverWithdrawalState createState() => _DriverWithdrawalState();
}

class _DriverWithdrawalState extends State<DriverWithdrawal> {


  String image;
  int payment = 1;
  TextEditingController _editingControllerMoney = new TextEditingController();
  TextEditingController _editingControllerAccount = new TextEditingController();
  TextEditingController _editingControllerName = new TextEditingController();

  FocusNode _focusNode = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();
  FocusNode _focusNode3 = new FocusNode();

  WithdraealBean bean;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData(){
    DioUtils.instance.post(Api.withdrawInfoUrl,onSucceed: (response){
        if(response is Map){
          setState(() {
            bean = WithdraealBean.fromJson(response);
          });
        }
    },onFailure: (code,msg){

    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActionWidget(
        list: [_focusNode,_focusNode2,_focusNode3],
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: ShowWhiteAppBar(
            centerTitle: '账户提现',
            rightWidget: AppButton(title: '提现说明', onPress: (){
              AppShowBottomDialog.showDelegateSheetDialog(context, '提现说明', bean?.content??'','', (){

              });
            }),
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 10.0,),
              ContainerAddLineWidget(
                  edgeInsets: EdgeInsets.all(0.0),
                  disW: 0.0,
                  child: Container(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 80.0,
                          child: AppText(alignment: Alignment.centerLeft,text: '提现账号'),
                        ),
                        SizedBox(
                          width: 150.0,
                          child: AppText(alignment: Alignment.centerLeft,fonSize: 16,text: SpUtil.getString(AppValue.login_account,defValue: '')),
                        ),
                        Expanded(
                            child: AppText(
                                alignment: Alignment.centerRight,
                                color: AppColors.black54Color,
                                fonSize: 13,
                                text: '(可提现: ${bean?.money??''})'
                            )
                        )
                      ],
                    ),
                  )
              ),
              ContainerAddLineWidget(
                  edgeInsets: EdgeInsets.all(0.0),
                  disW: 0.0,
                  child: Container(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 80.0,child: AppText(alignment: Alignment.centerLeft,text: '提现金额'),),
                        Expanded(
                          child: Container(
                            child: TextField(
                              controller: _editingControllerMoney,
                              focusNode: _focusNode,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 20,color: AppColors.mainColor),
                              inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                                hintText: '请输入提现金额',
                                hintStyle: TextStyle(color: AppColors.black54Color,fontSize: 14),
                                counterText: '',
                                border: new OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value){
                                setState(() {

                                });
                              },
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
              ContainerAddLineWidget(
                  edgeInsets: EdgeInsets.all(0.0),
                  disW: 0.0,
                  child: AppCell(alignment: Alignment.centerLeft,title: '手续费', content: '${bean?.percent_drive??''}%')),
              ContainerAddLineWidget(
                  edgeInsets: EdgeInsets.all(0.0),
                  disW: 0.0,
                  child: AppCell(
                    title: '实际到账金额',
                    content: _editingControllerMoney.text.isNotEmpty?'${double.parse(_editingControllerMoney.text)*((100-(int.parse(bean?.percent_drive??'0')))/100)}元':'0元',contentStyle: TextStyle(fontSize: 14,color: AppColors.red),
                  )
              ),
              ContainerAddLineWidget(
                edgeInsets: EdgeInsets.all(0.0),
                disW: 0.0,
                child: AppCell(
                    height: 20,
                    title: '最小提现金额',
                    titleStyle: TextStyle(fontSize: 14,color: AppColors.orangeColor),
                    content: '${bean?.min_money_drive??'0'}元',
                    contentStyle: TextStyle(fontSize: 12,color: AppColors.orangeColor),
                ),
              ),
              SizedBox(height: 10.0,),
//              ContainerAddLineWidget(
//                  edgeInsets: EdgeInsets.all(0.0),
//                  disW: 0.0,
//                  child: Container(
//                    padding: EdgeInsets.only(left: 16,right: 16),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        SizedBox(width: 100.0,child: AppText(alignment: Alignment.centerLeft,text: '选择账户类型'),),
//                        Expanded(child: SizedBox()),
//                        SizedBox(width: 100.0,child: AppButton(title: '微信',buttonType: ButtonType.leftImage,imageSize: 15,image: payment==1?'选择2':'选择1', onPress: (){
//                          setState(() {
//                            payment = 1;
//                          });
//                        }),),
//                        SizedBox(width: 100.0,child: AppButton(title: '支付宝',buttonType: ButtonType.leftImage,imageSize: 15,image: payment==2?'选择2':'选择1', onPress: (){
//                          setState(() {
//                            payment = 2;
//                          });
//                        }),),
//                      ],
//                    ),
//                  )
//              ),
//              ContainerAddLineWidget(
//                  edgeInsets: EdgeInsets.all(0.0),
//                  disW: 0.0,
//                  child: Container(
//                    padding: EdgeInsets.only(left: 16,right: 16),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        SizedBox(width: 80.0,child: AppText(alignment: Alignment.centerLeft,text: '账户'),),
//                        Expanded(
//                          child: Container(
//                            child: TextField(
//                              controller: _editingControllerAccount,
//                              focusNode: _focusNode2,
//                              keyboardType: TextInputType.text,
//                              textAlign: TextAlign.right,
//                              style: TextStyle(fontSize: 20,color: AppColors.mainColor),
//                              decoration: InputDecoration(
//                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
//                                hintText: '请输入提现账号',
//                                hintStyle: TextStyle(color: AppColors.black54Color,fontSize: 14),
//                                counterText: '',
//                                border: new OutlineInputBorder(
//                                  borderSide: BorderSide.none,
//                                ),
//                              ),
//                              onSubmitted: (value){
//                                _focusNode2.unfocus();
//                              },
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  )
//              ),
//              ContainerAddLineWidget(
//                  edgeInsets: EdgeInsets.all(0.0),
//                  disW: 0.0,
//                  child: Container(
//                    padding: EdgeInsets.only(left: 16,right: 16),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        SizedBox(width: 80.0,child: AppText(alignment: Alignment.centerLeft,text: '账号姓名'),),
//                        Expanded(
//                          child: Container(
//                            child: TextField(
//                              controller: _editingControllerName,
//                              focusNode: _focusNode3,
//                              keyboardType: TextInputType.text,
//                              textAlign: TextAlign.right,
//                              style: TextStyle(fontSize: 20,color: AppColors.mainColor),
//                              decoration: InputDecoration(
//                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
//                                hintText: '请输入提现账号姓名',
//                                hintStyle: TextStyle(color: AppColors.black54Color,fontSize: 14),
//                                counterText: '',
//                                border: new OutlineInputBorder(
//                                  borderSide: BorderSide.none,
//                                ),
//                              ),
//                              onSubmitted: (value){
//                                _focusNode3.unfocus();
//                              },
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  )
//              ),
//              Container(color: AppColors.whiteColor,padding: EdgeInsets.only(left: 16,right: 16),child: TextContainer(title: '上传收款码', height: 40.0, style: TextStyles.blackAnd14)),
//              AppAddImageWidget(
//                  imageFiles: (List list){
//                    image = list.first;
//                  }
//              ),


              SizedBox(height: 150.0,),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                height: 45.0,
                alignment: Alignment.center,
                child: SizedBox(
                  height: 45.0,
                  child: AppButton(radius: 45.0, bgColor: AppColors.mainColor,title: '申请提现',textStyle: TextStyles.whiteAnd14, onPress:(){
                    startSubmit();
                  }),
                ),
              )
            ],
          ),
        )
    );
  }

  startSubmit(){
    if(_editingControllerMoney.text.isEmpty){
      Toast.show('请输入提现金额');
      return;
    }
    if(double.parse(_editingControllerMoney.text)<double.parse(bean?.min_money_drive??'0')){
      Toast.show('提现金额不得小于最小提现金额');
      return;
    }
    var data = {
      'id':widget.idStr,
      'money':_editingControllerMoney.text
    };
    DioUtils.instance.post(Api.withdrawSubmitApplicationUrl,data: data,onSucceed: (response){
      Toast.show('发起提现申请成功！');
      Navigator.pop(this.context);
    },onFailure: (code,msg){

    });
  }


}


class WithdraealBean {
    String content;
    String min_money_drive;
    String money;
    String percent_drive;

    WithdraealBean({this.content, this.min_money_drive, this.money, this.percent_drive});

    factory WithdraealBean.fromJson(Map<String, dynamic> json) {
        return WithdraealBean(
            content: json['content'], 
            min_money_drive: json['min_money_drive'].toString(),
            money: json['money'].toString(),
            percent_drive: json['percent_drive'].toString(),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['content'] = this.content;
        data['min_money_drive'] = this.min_money_drive;
        data['money'] = this.money;
        data['percent_drive'] = this.percent_drive;
        return data;
    }
}