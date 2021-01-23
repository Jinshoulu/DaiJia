
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:flutter/material.dart';

class OrderDeclaration extends StatefulWidget {
  @override
  _OrderDeclarationState createState() => _OrderDeclarationState();
}

class _OrderDeclarationState extends State<OrderDeclaration> {

  TextEditingController _editingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  String selectItemValue = '男';

  @override
  Widget build(BuildContext context) {
    return KeyboardActionWidget(
        list: [_focusNode],
        child: Scaffold(
          appBar: ShowWhiteAppBar(
            centerTitle: '报单',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-100,
                  child: Column(
                    children: <Widget>[
                      AppSizeBox(),
                      ContainerAddLineWidget(
                          disW: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16,right: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 100.0,
                                  child: AppText(alignment: Alignment.centerLeft,text: '车牌号'),
                                ),
                                Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: createCarNumber(),
                                    )
                                )
                              ],
                            ),
                          )
                      ),
                      ContainerAddLineWidget(
                          disW: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16,right: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 100.0,
                                  child: AppText(alignment: Alignment.centerLeft,text: '车主性别'),
                                ),
                                Expanded(child: SizedBox(),),
                                Container(
                                  width: 100.0,
                                  height: 30.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.inputBgColor,
                                      borderRadius: BorderRadius.all(Radius.circular(4))
                                  ),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: selectItemValue,
                                        hint: Text('请选择'),
                                        items: ['男','女'].map((String name){
                                          return new DropdownMenuItem(
                                            child: Container(child: new Text(name,style: TextStyles.blackAnd14,)),
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
                                )
                              ],
                            ),
                          )
                      ),
                      AppCell(title: '备注', content: ''),
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
                              hintText: '请输入备注信息...',
                              border:
                              OutlineInputBorder(borderSide: BorderSide.none)
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.only(left: 16,right: 16),
                        child: SizedBox(
                          height: 45.0,
                          child: AppButton(title: '确认',radius: 45.0,bgColor: AppColors.mainColor,textStyle: TextStyles.whiteAnd14, onPress: (){
                            Navigator.pop(context);
                            AppShowBottomDialog.showCallPhoneDialog('15151353545', context);
                          }),
                        ),
                      ),
                      SizedBox(height: 60.0,),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  createCarNumber(){
    List<Widget> list = [];
    String number = '豫A23568';
    for(int i = 0; i<number.length; i++){
      list.add(Container(
        width: 25,height: 35,
        decoration: BoxDecoration(
          color: AppColors.inputBgColor,
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        alignment: Alignment.center,
        child: Text(number.substring(i,i+1),style: TextStyle(fontSize: 14,color: AppColors.mainColor),),
      ));
      if(i==1){
        list.add(Container(
          width: 25,height: 35,
          alignment: Alignment.center,
          child: Container(
            width: 10,height: 10,
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        ));
      }else{
        list.add(SizedBox(width: 5,));
      }

    }
    return list;
  }
}
