
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_desc_widget.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/image/AppSubmitImage.dart';
import 'package:flutter/material.dart';

class MineCompleteInfo extends StatefulWidget {
  @override
  _MineCompleteInfoState createState() => _MineCompleteInfoState();
}

class _MineCompleteInfoState extends State<MineCompleteInfo> {

  ///身份证
  String idCardOne = '';
  String idCardTwo = '';
  String submitCardOne = '';
  String submitCardTwo = '';

  ///驾驶证
  String drivingLicenceOne = '';
  String drivingLicenceTwo = '';
  String submitDriveingOne = '';
  String submitDriveingTwo = '';
  ///上传兼职代驾协议
  String delegateOne = '';
  String delegateTwo = '';
  String delegateThree = '';
  String submitDelegateOne = '';
  String submitDelegateTwo = '';
  String submitDelegateThree = '';
  ///上传工装半身照
  String photo = '';
  String submitPhoto = '';
  ///审核状态
  int applicationStatus = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '司机资料上传',
        rightWidget: AppButton(
            title: '平安到家',
            textStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),
            onPress: (){

            }
        ),
      ),
      body: AppStackWidget(
          topWidget: Container(
            child: ListView(
              children: <Widget>[
                AppSizeBox(height: 10.0,color: AppColors.bgColor,),
                AppCell(title: '上传身份证', content: ''),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  height: 150.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      createContainer('正面', idCardOne,0),
                      SizedBox(width: 16,),
                      createContainer('反面', idCardTwo,1),
                      SizedBox(width: 16,),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                AppSizeBox(height: 10.0,color: AppColors.bgColor,),
                AppCell(title: '上传驾驶证', content: ''),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  height: 150.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      createContainer('正本', drivingLicenceOne,2),
                      SizedBox(width: 16,),
                      createContainer('副本', drivingLicenceTwo,3),
                      SizedBox(width: 16,),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                AppSizeBox(height: 10.0,color: AppColors.bgColor,),
                AppCell(title: '上传兼职代驾协议', content: ''),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  height: 150.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      createContainer('第一页', delegateOne,4),
                      SizedBox(width: 16,),
                      createContainer('第二页', delegateTwo,5),
                      SizedBox(width: 16,),
                      createContainer('第三页', delegateThree,6),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  height: 150.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      createContainer('上穿工装半身照', photo,7),
                      SizedBox(width: 16,),
                      Expanded(child: SizedBox()),
                      SizedBox(width: 16,),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                applicationStatus==1?
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          AppCell(title: '审核状态', content: '正在审核',contentStyle: TextStyle(fontSize: 12,color: AppColors.red),),
                          AppDescWidget(text: '这个就是审核的状态反馈')
                        ],
                      ),
                    )
                    :SizedBox(),
                SizedBox(height: 60.0,)
              ],
            ),
          ),
          height: 80.0,
          downWidget: Container(
            height: 80.0,
            padding: EdgeInsets.only(left: 16,right: 16),
            alignment: Alignment.center,
            child: SizedBox(
              height: 45.0,
              child: AppButton(
                  radius: 45.0,
                  title: '提交审核',
                  textStyle: TextStyles.whiteAnd14,
                  bgColor: AppColors.mainColor,
                  onPress: (){

                  }
              ),
            ),
          )
      ),
    );
  }

  createContainer(String title,String image,int index){
    return Expanded(
        child: InkWell(
          onTap: (){
            AppSubmitImage.showDialog(this.context,(ImageBean bean){
              String file1 = bean.data.fileurl;
              String file2 = bean.data.fileurls;
              switch(index){
                case 0:{//身份证正面
                  setState(() {
                    idCardOne = file1;
                    submitCardOne = file2;
                  });
                }break;
                case 1:{//身份证反面
                  setState(() {
                    idCardTwo = file1;
                    submitCardTwo = file2;
                  });
                }break;
                case 2:{//驾驶证正本
                  setState(() {
                    drivingLicenceOne = file1;
                    submitDriveingOne = file2;
                  });
                }break;
                case 3:{//驾驶证副本
                  setState(() {
                    drivingLicenceTwo = file1;
                    submitDriveingTwo = file2;
                  });
                }break;
                case 4:{//协议第一页
                  setState(() {
                    delegateOne = file1;
                    submitDelegateOne = file2;
                  });
                }break;
                case 5:{//协议第二页
                  setState(() {
                    delegateTwo = file1;
                    submitDelegateTwo = file2;
                  });
                }break;
                case 6:{//协议第三页
                  setState(() {
                    delegateThree = file1;
                    submitDelegateThree = file2;
                  });
                }break;
                case 7:{//工装半身照
                  setState(() {
                    photo = file1;
                    submitPhoto = file2;
                  });
                }break;
                default:{}break;
              }
            });

          },
          child: Column(
            children: <Widget>[
              image.contains('http')?
              LoadImage(image,fit: BoxFit.fitWidth,radius: 0.0,):
              LoadAssetImage('添加图片',radius: 0.0,),
              Expanded(
                  child: AppText(text: title,fonSize: 12)
              )
            ],
          ),
        )
    );
  }


  submitInfo(){
    if(idCardOne.isEmpty){
      Toast.show('请上传身份证正面照');
      return;
    }
    if(idCardTwo.isEmpty){
      Toast.show('请上传身份证反面照');
      return;
    }
    if(drivingLicenceOne.isEmpty){
      Toast.show('请上传驾驶证正本照');
      return;
    }
    if(drivingLicenceTwo.isEmpty){
      Toast.show('请上传驾驶证副本照');
      return;
    }
    if(delegateOne.isEmpty){
      Toast.show('请上传代驾协议第一页照片');
      return;
    }
    if(delegateTwo.isEmpty){
      Toast.show('请上传代驾协议第二页照片');
      return;
    }
    if(delegateThree.isEmpty){
      Toast.show('请上传代驾协议第三页照片');
      return;
    }
    if(photo.isEmpty){
      Toast.show('请上传工装半身照');
      return;
    }
    var data = {
      'fileurl3':submitCardOne,
      'fileurl4':submitCardTwo,
      'fileurl1':submitDriveingOne,
      'fileurl2':submitDriveingTwo,
      'fileurl5':submitDelegateOne,
      'fileurl6':submitDelegateTwo,
      'fileurl7':submitDelegateThree,
      'fileurl8':submitPhoto
    };
    DioUtils.instance.post(Api.mineSubmitApplicationInfoUrl,data:data,onFailure: (code,msg){

    },onSucceed: (response){
      Toast.show('已提交');
        AppPush.goBack(this.context);
    });
  }

}
