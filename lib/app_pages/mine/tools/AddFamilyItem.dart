
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/res/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class AddFamilyItem extends StatefulWidget {
  @override
  _AddFamilyItemState createState() => _AddFamilyItemState();
}

class _AddFamilyItemState extends State<AddFamilyItem> {

  TextEditingController _editingController = new TextEditingController();
  TextEditingController _editingControllerName = new TextEditingController();

  FocusNode _focusNode = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();


  @override
  Widget build(BuildContext context) {
    return KeyboardActionWidget(
        list: [_focusNode,_focusNode2],
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 50.0,
                      child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: '号码',
                                    style: TextStyles.blackAnd14
                                ),
                                TextSpan(
                                    text: '*',
                                    style: TextStyle(fontSize: 14,color: AppColors.red)
                                )
                              ]
                          )
                      ),
                    ),
                    Expanded(
                      child: ContainerAddLineWidget(
                        child: TextField(
                          controller: _editingController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: '请输入亲情号码',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                          onSubmitted: (value){
                            _focusNode.unfocus();
                            _focusNode2.unfocus();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 50.0,
                      child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: '姓名',
                                    style: TextStyles.blackAnd14
                                ),
                                TextSpan(
                                    text: '*',
                                    style: TextStyle(fontSize: 14,color: AppColors.red)
                                )
                              ]
                          )
                      ),
                    ),
                    Expanded(
                      child: ContainerAddLineWidget(
                        child: TextField(
                          controller: _editingControllerName,
                          decoration: InputDecoration(
                              hintText: '请输入姓名',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )
                          ),
                          onSubmitted: (value){
                            _focusNode.unfocus();
                            _focusNode2.unfocus();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40.0,),
              Container(
                height: 75.0,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 45.0,
                      width: 120,
                      child: AppButton(radius: 45.0,title: '取消',bgColor: AppColors.bgColor,
                          textStyle: TextStyle(fontSize: 14,color: AppColors.black54Color),onPress: () {
                            Navigator.pop(context);
                          }),
                    ),
                    SizedBox(
                      height: 45.0,
                      width: 120.0,
                      child: AppButton(radius: 45.0,title: '确定',bgColor: AppColors.mainColor, textStyle: TextStyles.whiteAnd14,onPress: () {
                        Navigator.pop(context);
                        _focusNode.unfocus();
                        _focusNode2.unfocus();
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      }),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
