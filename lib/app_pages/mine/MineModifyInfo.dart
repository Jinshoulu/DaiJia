
import 'package:demo/provider/user_info.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/keyboard_action_widget.dart';
import 'package:demo/z_tools/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MineModifyInfo extends StatefulWidget {
  //0.修改昵称 1.修改驾龄
  final int type;

  const MineModifyInfo({Key key, this.type = 0}) : super(key: key);

  @override
  _MineModifyInfoState createState() => _MineModifyInfoState();
}

class _MineModifyInfoState extends State<MineModifyInfo> {

  TextEditingController _editingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.type==0){
      _editingController.text = Provider.of<UserInfo>(context,listen: false).nickname;
    }else{
      _editingController.text = Provider.of<UserInfo>(context,listen: false).work_time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActionWidget(
        list: [_focusNode],
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: ShowWhiteAppBar(
            centerTitle: widget.type==0?'修改昵称':'修改驾龄',
            rightWidget: AppButton(
                title: '保存',
                onPress: (){
                  requestModify();
                }
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 16,right: 16),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  child: AppTextField(
                      allowChinese: true,
                      edgeInsets: EdgeInsets.only(left: 16),
                      keyName: 'modify',
                      controller: _editingController,
                      keyboardType: widget.type==0?TextInputType.text:TextInputType.phone,
                      mode: TexFieldMode.none,
                      hintText: '请输入${widget.type==0?'新的昵称':'新的驾龄'}',
                      focusNode: _focusNode
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  requestModify(){

    if(_editingController.text.isEmpty){
      Toast.show('内容不能为空');
      return;
    }

    var data;
    String requestUrl = '';
    if(widget.type==0){
      data = {
        'nickname': _editingController.text,
      };
      requestUrl = Api.mineModifyNickNameUrl;
    }else{
      data = {
        'work_time': _editingController.text,
      };
      requestUrl = Api.mineDriverAgeUrl;
    }
    DioUtils.instance.post(requestUrl,data: data,onSucceed: (response){
      if(widget.type==0){
        Provider.of<UserInfo>(this.context,listen: false).nickname = _editingController.text;
      }else{
        Provider.of<UserInfo>(this.context,listen: false).work_time = _editingController.text;
      }
      Toast.show('修改成功');
      AppPush.goBack(this.context);

    },onFailure: (code,msg){

    });

  }
}
