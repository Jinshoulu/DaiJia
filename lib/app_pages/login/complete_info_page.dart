
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_add_images_widget.dart';
import 'package:demo/z_tools/app_widget/app_label_cell.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

class CompleteInfoPage extends StatefulWidget {
  @override
  _CompleteInfoPageState createState() => _CompleteInfoPageState();
}

class _CompleteInfoPageState extends State<CompleteInfoPage> {

  TextEditingController _editingControllerName = new TextEditingController();
  TextEditingController _editingControllerId= new TextEditingController();

  FocusNode _focusNodeName = new FocusNode();
  FocusNode _focusNodeId = new FocusNode();

  List idCards = [];
  List carIds = [];

  @override
  Widget build(BuildContext context) {
    return KeyboardActionWidget(
        list: [_focusNodeName,_focusNodeId],
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: ShowWhiteAppBar(
            centerTitle: '完善资料',
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  AppTextField(
                      keyName: 'name',
                      allowChinese: true,
                      controller: _editingControllerName,
                      mode: TexFieldMode.fourMode,
                      showPass: true,
                      leftImage: '完善姓名',
                      hintText: '请输入姓名',
                      focusNode: _focusNodeName
                  ),
                  AppTextField(
                      keyName: 'card',
                      controller: _editingControllerId,
                      mode: TexFieldMode.fourMode,
                      showPass: true,
                      leftImage: '完善身份证',
                      hintText: '请输入身份证号',
                      focusNode: _focusNodeId
                  ),
                  AppSizeBox(),
                  AppLabelCell(
                    title: '上传身份证',
                    showRightImage: false,
                    showLine: false,
                    onPress: (){},
                  ),
                  AppAddImageWidget(
                      imageFiles: (List images){
                        idCards = images;
                      }
                  ),
                  AppSizeBox(color: Colors.white,),
                  AppSizeBox(),
                  AppLabelCell(
                    title: '上传驾驶证',
                    showRightImage: false,
                    showLine: false,
                    onPress: (){},
                  ),
                  AppAddImageWidget(
                      imageFiles: (List images){
                        carIds = images;
                      }
                  ),
                  AppSizeBox(color: Colors.white,),
                  AppSizeBox(),
                  SizedBox(height: 70.0,),
                  SizedBox(
                    height: 50.0,
                    child: AppButton(
                        radius: 50.0,
                        bgColor: AppColors.mainColor,
                        title: '确认',
                        textStyle: TextStyles.whiteAnd14,
                        onPress: (){

                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
