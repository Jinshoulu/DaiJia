
import 'package:demo/app_pages/mine/bean/SpotCheckBean.dart';
import 'package:demo/app_pages/mine/tools/SpotCheckItem.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_bus_event.dart';
import 'package:demo/z_tools/app_widget/app_add_images_widget.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/material.dart';

class MineSpotCheck extends StatefulWidget {
  @override
  _MineSpotCheckState createState() => _MineSpotCheckState();
}

class _MineSpotCheckState extends State<MineSpotCheck> {

  List dataList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowWhiteAppBar(
        centerTitle: '抽检列表',
      ),
      body: AppRefreshWidget(
          itemBuilder: (BuildContext context,int index){
            return createContainerItem();
          },
          requestData: {},
          requestUrl: Api.mineSpotCheckRecordUrl,
          requestBackData: (List list){
            if(mounted){
              setState(() {
                dataList = list;
              });
            }
          }
      ),
    );
  }

  createContainerItem(){

    SpotCheckBean bean = SpotCheckBean();
    return Container(
      color: AppColors.whiteColor,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          ContainerAddLineWidget(
              child: AppCell(title: '抽检时间: 2021-12-12 12:12', content: '上传时间: 2021-12-12 14:12')
          ),
          SizedBox(height: 20.0,),
          bean.fileurls==null?SizedBox()
              :GridView.builder(
            padding: EdgeInsets.only(left: 16,right: 16),
              shrinkWrap: true,
              itemCount: bean?.fileurls?.length,
              physics: new NeverScrollableScrollPhysics(),
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
                return Container(
                  child: LoadImage(bean?.fileurls[index],radius: 0.0,),
                );
              }
          ),
          SizedBox(height: 20.0,),
        ],
      ),
    );
  }

  createEditContainer(){

    return SpotCheckItem(
        submitResult: (){
          eventBus.fire(ReloadListPage());
        },
        bean: SpotCheckBean()
    );
  }
}
