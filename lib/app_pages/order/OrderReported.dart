
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_add_images_widget.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:flutter/material.dart';

class OrderReported extends StatefulWidget {

  final String orderId;

  const OrderReported({Key key,@required this.orderId}) : super(key: key);


  @override
  _OrderReportedState createState() => _OrderReportedState();
}

class _OrderReportedState extends State<OrderReported> {

  TextEditingController _editingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  List images = [];

  @override
  Widget build(BuildContext context) {

    return KeyboardActionWidget(
        list: [_focusNode],
        child: Scaffold(
          appBar: ShowWhiteAppBar(
            centerTitle: '报备',
          ),
          body: ListView(
            children: <Widget>[
              AppSizeBox(),
              Container(
                height: 120.0+32.0+32.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    LoadAssetImage('订单-报备背景',radius: 0.0,),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppCell(
                            title: '订单号',
                            titleStyle: TextStyles.whiteAnd14,
                            content: '202000345646854',
                            contentStyle: TextStyles.whiteAnd14,
                            height: 35,
                          ),
                          AppCell(
                            title: '客户手机号',
                            titleStyle: TextStyles.whiteAnd14,
                            content: '15542425689',
                            contentStyle: TextStyles.whiteAnd14,
                            height: 35,
                          ),
                          AppCell(
                            title: '起始地',
                            titleStyle: TextStyles.whiteAnd14,
                            content: '金成时代广场',
                            contentStyle: TextStyles.whiteAnd14,
                            height: 35,
                          ),
                          AppCell(
                            title: '目的地',
                            titleStyle: TextStyles.whiteAnd14,
                            content: '绿城公园',
                            contentStyle: TextStyles.whiteAnd14,
                            height: 35,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              AppCell(title: '报备内容', content: ''),
              SizedBox(height: 16,),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                height: 150.0,
                child: TextField(
                  controller: _editingController,
                  focusNode: _focusNode,
                  onSubmitted: (result) {
                    _focusNode.unfocus();
                  },
                  maxLines: 15,
                  decoration: new InputDecoration(
                      fillColor: AppColors.inputBgColor,
                      filled: true,
                      hintText: '请输入报备内容...',
                      border:
                      OutlineInputBorder(borderSide: BorderSide.none)
                  ),
                ),
              ),
              AppCell(title: '凭证上传', content: ''),
              AppAddImageWidget(
                  imageFiles: (List list){
                    images = list;
                  }
              ),
              SizedBox(height: 30.0,),
              Padding(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: SizedBox(
                  height: 45.0,
                  child: AppButton(title: '确认',radius: 45.0,bgColor: AppColors.mainColor,textStyle: TextStyles.whiteAnd14, onPress: (){

                  }),
                ),
              ),
              SizedBox(height: 30.0,),
            ],
          ),
        )
    );

  }
}
