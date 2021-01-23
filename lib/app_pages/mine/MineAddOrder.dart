
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppNormalButton.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class MineAddOrder extends StatefulWidget {
  @override
  _MineAddOrderState createState() => _MineAddOrderState();
}

class _MineAddOrderState extends State<MineAddOrder> {

  TextEditingController _editingController = new TextEditingController();
  TextEditingController _editingControllerPhone = new TextEditingController();
  TextEditingController _editingControllerPhone2 = new TextEditingController();

  FocusNode _focusNode = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();
  FocusNode _focusNode3 = new FocusNode();

  String selectItemValue = '自主开单';
  String selectItemValue2 = '日常代驾';

  String orderTime = '';

  @override
  Widget build(BuildContext context) {
    return KeyboardActionWidget(
        list: [_focusNode,_focusNode2,_focusNode3],
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: ShowWhiteAppBar(
            centerTitle: '人工补单',
            rightWidget: AppButton(
                title: '平安到家',
                textStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),
                onPress: (){

                }
            ),
          ),
          body: SingleChildScrollView(
            physics: new NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.bottom-50,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  createContainer('订单来源:', Container(
                    width: 160.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.inputBgColor,
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child:  DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: selectItemValue,
                          hint: Text('请选择订单来源'),
                          items: ['自主开单','自主开单2'].map((String name){
                            return new DropdownMenuItem(
                              child: Container(alignment: Alignment.center,child: new Text(name,style: TextStyles.blackAnd14,)),
                              value: name,
                            );
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              selectItemValue=value;
                            });
                          }
                      ),
                    ),
                  )),
                  createContainer('订单类型:', Container(
                    width: 160.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.inputBgColor,
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child:  DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: selectItemValue2,
                          hint: Text('请选择订单类型'),
                          items: ['日常代驾','日常代驾2'].map((String name){
                            return new DropdownMenuItem(
                              child: Container(child: new Text(name,style: TextStyles.blackAnd14,)),
                              value: name,
                            );
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              selectItemValue2=value;
                            });
                          }
                      ),
                    ),
                  )),
                  SizedBox(height: 10,),
                  createContainer('订单金额:',
                      Container(
                        width: 200,
                        child: TextField(
                          controller: _editingController,
                          focusNode: _focusNode,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                              hintText: '请输入订单金额',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                          onSubmitted: (value){
                            hiddenKeyboard();
                          },
                        ),
                      )
                  ),
                  createContainer('客户电话:',
                      Container(
                        width: 200,
                        child: TextField(
                          controller: _editingControllerPhone,
                          focusNode: _focusNode2,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: '请输入客户电话',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                          onSubmitted: (value){
                            hiddenKeyboard();
                          },
                        ),
                      )
                  ),
                  createContainer('代叫人电话:',
                      Container(
                        width: 200,
                        child: TextField(
                          controller: _editingControllerPhone2,
                          focusNode: _focusNode3,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: '请输入代叫人电话',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                          onSubmitted: (value){
                            hiddenKeyboard();
                          },
                        ),
                      )
                  ),
                  createContainer('订单时间:',
                      InkWell(
                        onTap: (){
                          showPickerDate(this.context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: AppText(alignment: Alignment.centerRight,text: orderTime.isEmpty?'请输入订单时间':orderTime),
                        ),
                      )
                  ),
                  Expanded(child: SizedBox()),
                  AppNormalButton(
                      title: '补单',
                      onPress: (){

                      }
                  ),
                  SizedBox(height: 100,),

                ],
              ),
            ),
          ),
        )
    );
  }

  hiddenKeyboard(){
    _focusNode.unfocus();
    _focusNode2.unfocus();
    _focusNode3.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  createContainer(String title,Widget child){
    return ContainerAddLineWidget(
        disW: 0.0,
        edgeInsets: EdgeInsets.only(left: 16,right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100.0,
              child: AppText(
                  alignment: Alignment.centerLeft,
                  text: title
              ),
            ),
            Expanded(child: SizedBox()),
            child
          ],
        )
    );
  }

  showPickerDate(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD,
//          months: ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],
            months: ['1','2','3','4','5','6','7','8','9','10','11','12']
        ),
        title: Text("选择时间"),
        selectedTextStyle: TextStyle(color: AppColors.mainColor),
        onConfirm: (Picker picker, List value) {
          DateTime dateTime =  (picker.adapter as DateTimePickerAdapter).value;
          setState(() {
            orderTime = dateTime.year.toString()+'-'+dateTime.month.toString()+'-'+dateTime.day.toString();
          });
        }
    ).showDialog(context);
  }
}
