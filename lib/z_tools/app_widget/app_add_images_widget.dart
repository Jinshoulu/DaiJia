
import 'package:demo/z_tools/image/AppSubmitImage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../public_header.dart';


class AppAddImageWidget extends StatefulWidget {

  final Color bgColor;
  final String addBtnImage;
  final List<ImageBean> showImages;
  final Function imageFiles;
  final int maxCount;

  const AppAddImageWidget({
    Key key,
    @required this.imageFiles,
    this.bgColor = AppColors.whiteColor,
    this.addBtnImage = '添加图片',
    this.maxCount = 9, this.showImages,
  }) : super(key: key);

  @override
  _AppAddImageWidgetState createState() => _AppAddImageWidgetState();
}

class _AppAddImageWidgetState extends State<AppAddImageWidget> {

  List<ImageBean> images = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = widget.showImages;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      padding: EdgeInsets.only(left: 16,right: 16),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: (widget.maxCount==images.length?images.length:(images.length+1)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
              crossAxisCount: 4,
              //纵轴间距
              mainAxisSpacing: 20.0,
              //横轴间距
              crossAxisSpacing: 10.0,
              //子组件宽高长度比例
              childAspectRatio: 1.0),
          itemBuilder: (BuildContext context, int index){
            return getItemContainer(index);
          }
      ),
    );
  }

  getItemContainer(int index){

    if(index==images.length){
      return InkWell(
        onTap: ()async{
          Permission.photos.request().then((value)async{
            if(value.isGranted){
              AppSubmitImage.showDialog(this.context,(ImageBean bean){
                String file1 = bean.data.fileurl;//全路径
                String file2 = bean.data.fileurls;//版路径
                debugPrint('all file = $file1, file = $file2');
                images.add(bean);
                widget.imageFiles(images);
                setState(() {});
              });
//              AppShowBottomDialog.showPhotoBottom(context, (String path){
//                debugPrint(path);
//                images.add(path);
//                widget.imageFiles(images);
//                setState(() {});
//              });
            }else{
              Toast.show('检测到您拒绝访问相册权限,请到应用设置页面打开权限');
            }
          });
        },
        child: Container(
          alignment: Alignment.center,
          child: LoadImage(widget.addBtnImage,radius: 0.0,),
        ),
      );
    }else{
      return Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(5),
                child: LoadImage(images[index].data.fileurl,fit: BoxFit.cover,)
            ),
            Positioned(
                child: InkWell(
                  onTap: (){
                    images.removeAt(index);
                    widget.imageFiles(images);
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: LoadAssetImage('订单-删除',width: 15,height: 15,radius: 0.0,),
                  ),
                )
            )
          ],
        ),
      );
    }
  }
}
