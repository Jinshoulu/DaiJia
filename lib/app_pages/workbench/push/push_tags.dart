
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/my_separator.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/image/image_header.dart';
import 'package:flutter/material.dart';

class PushTags extends StatefulWidget {
  @override
  _PushTagsState createState() => _PushTagsState();
}

class _PushTagsState extends State<PushTags> {

  var infoData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();

  }

  getData(){

    DioUtils.instance.post(Api.homeGetOfficialInfoUrl,onSucceed: (response){

      if(response is Map){
        if(mounted){
          setState(() {
            infoData = response;
          });
        }
      }

    },onFailure: (code,msg){

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoadAssetImage('推广背景',format: 'jpg',radius: 0.0,),
          CustomScrollView(
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
                title: Text('红包电子吊牌'),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-60.0,
                  padding: EdgeInsets.only(left: 30,right: 30,bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40.0,),
                      Container(
                        height: 70.0,
                        alignment: Alignment.center,
                        child: LoadAssetImage('推广-标兵代驾',height: 70.0,fit: BoxFit.fitHeight,radius: 0.0,),
                      ),
                      SizedBox(height: 40.0,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            color: ColorsApp.whiteColor,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                height: 90.0,
                                child: Row(
                                  children: <Widget>[
                                    ImageHeader(height: 70,image: AppClass.data(infoData, 'headimg')),
                                    SizedBox(width: 10,),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(text: AppClass.data(infoData, 'nickname'),style: TextStyle(fontSize: 17,color: AppColors.blackColor)),
                                                    TextSpan(text: '(工号: ${AppClass.data(infoData, 'code')})',style: TextStyle(fontSize: 14,color: AppColors.black54Color)),
                                                  ])),
                                            ),
                                          ),
                                          Expanded(child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  child:LoadAssetImage('推广-驾驶',width: 18,fit: BoxFit.fitWidth,radius: 0.0),
                                                ),
                                                SizedBox(width: 5,),
                                                Expanded(child: Text('${AppClass.data(infoData, 'work_time')}年驾龄',style: TextStyle(fontSize: 14,color: AppColors.blackColor),))
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 1,
                                child: MySeparator(),
                              ),
                              Expanded(child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: LoadImage(AppClass.data(infoData, 'code_url'),radius: 0.0,),
                              )),
                              TextContainer(alignment: Alignment.center,title: '扫码即可下单', height: 30.0, style: TextStyles.blackAnd14),
                              TextContainer(
                                  alignment: Alignment.center,
                                  title: '最高可减100元,请先领券后下单',
                                  height: 30.0,
                                  style: TextStyle(fontSize: 14,color: AppColors.red)),
                              SizedBox(height: 20.0,)

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 60.0,)


//                      SizedBox(
//                        height: 60.0,
//                        child: AppButton(title: '保存到相册',textStyle: TextStyle(fontSize: 15,color: AppColors.orangeColor), onPress: (){
//                          AppShowBottomDialog.showFoundSaveDone(context, [''], () {
//
//                          });
//                        }),
//                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }


}


