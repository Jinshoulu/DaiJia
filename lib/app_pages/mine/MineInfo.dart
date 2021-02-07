
import 'package:demo/app_pages/mine/MineModifyInfo.dart';
import 'package:demo/provider/user_info.dart';
import 'package:demo/z_tools/app_widget/app_set_cell.dart';
import 'package:demo/z_tools/app_widget/app_title_and_widget.dart';
import 'package:demo/z_tools/app_widget/app_user_header_item.dart';
import 'package:demo/z_tools/image/AppSubmitImage.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../public_header.dart';

class MineInfoPage extends StatefulWidget {
  @override
  _MineInfoPageState createState() => _MineInfoPageState();
}

class _MineInfoPageState extends State<MineInfoPage> {


  BuildContext _buildContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    

  }
  
  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    _buildContext = context;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowWhiteAppBar(
        centerTitle: '个人信息',
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
          Container(
            color: AppColors.whiteColor,
            child: AppUserHeaderItem(
              size: 70.0,
              title: '头像',
              header: Provider.of<UserInfo>(context).headimage??"",
              onPress: (){
                AppSubmitImage.showDialog(this.context,(ImageBean bean){
                  String file1 = bean.data.fileurl;
                  String file2 = bean.data.fileurls;
                  modifyHeaderImage(file1,file2);
                });
              },
            ),
          ),
          SizedBox(height: 1,),
          Container(
            color: AppColors.whiteColor,
            child: AppTitleAndWidget(
              title: '姓名',
              onPress: (){
                AppPush.pushDefault(context, MineModifyInfo(type: 0,));
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(Provider.of<UserInfo>(context).nickname??"",style: isDark?TextStyles.whiteAnd14:TextStyles.blackAnd14,),
                    SizedBox(width: 5,),
//                  LoadAssetImage('images/实名认证',height: 40,fit: BoxFit.fitHeight,),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 1,),
          AppSetCell(title: '驾龄',content: Provider.of<UserInfo>(this.context).work_time??'', onPress: (){
            AppPush.pushDefault(context, MineModifyInfo(type: 1,));
          })

        ],
      ),
    );
  }

  modifyHeaderImage(String image,String image2){

    var parameters = {'headimg':image2};
    DioUtils.instance.post(Api.mineModifyHeaderImageUrl,data: parameters,onSucceed: (result){
      Toast.show('更换成功');
      Provider.of<UserInfo>(this.context,listen: false).headimage = image;
      setState(() {

      });
    },onFailure: (code,msg){

    });
  }

}
