
import 'package:demo/z_tools/app_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../../public_header.dart';

class MineService extends StatelessWidget {

  List<String> images = ['账户充值','司机学堂','我的订单','电子工牌','抽检列表','收费标准','修改密码','公告列表','亲情号码','人工补单'];

  final Function (String) onPress;
  MineService({Key key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context,int index){
          return AppButton(
            title: images[index],
            image: images[index],
            buttonType: ButtonType.upImage,
            onPress: (){
              onPress(images[index]);
            },
          );
        },childCount: images.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          childAspectRatio: 1.4,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0
        )
    );
  }

}

class MineOtherService extends StatefulWidget {

  final Function (String) onPress;

  const MineOtherService({Key key, this.onPress}) : super(key: key);

  @override
  _MineOtherServiceState createState() => _MineOtherServiceState();
}

class _MineOtherServiceState extends State<MineOtherService> {

  List<String> images = ['服务协议','订单问题','资料上传','其他问题','版本检查','关于我们'];

  String version;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PackageInfo.fromPlatform().then((value){
        if(mounted){
          setState(() {
            version = value.version;
          });
        }
    });
  }



  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context,int index){
          if(images[index]=='版本检查'){
            return InkWell(
              onTap: (){
                widget.onPress(images[index]);
              },
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 25,
                            height: 25,
                            child: LoadAssetImage(images[index],radius: 0.0,),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            height: 20,
                            child: Text(images[index],style: TextStyle(fontSize: 14,color: AppColors.blackColor),),
                          ),
                        ],
                      )
                  ),
                  Positioned(
                    left: 0,right: 0,bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 12,
                        child: Text(version??'',style: TextStyle(fontSize: 10,color: AppColors.black54Color),),
                      )
                  )

                ],
              ),
            );

          }else{
            return AppButton(
              title: images[index],
              image: images[index],
              buttonType: ButtonType.upImage,
              onPress: (){
                widget.onPress(images[index]);
              },
            );
          }

        },childCount: images.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.4,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0
        )
    );
  }
}


