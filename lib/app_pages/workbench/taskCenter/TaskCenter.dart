
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/load_image.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

class TaskCenter extends StatefulWidget {
  @override
  _TaskCenterState createState() => _TaskCenterState();
}

class _TaskCenterState extends State<TaskCenter> {

  int mSelected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(delegate: SliverAppBarDelegate(Container(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                LoadAssetImage('任务中心背景',format: 'jpg',radius: 0.0,),
                Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).padding.top,),
                    Container(
                      height: 48,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 48,height: 48,child: AppButton(title: null,buttonType: ButtonType.onlyImage,imageColor: AppColors.whiteColor,image: 'back_black',imageSize: 25, onPress: (){
                            AppPush.goBack(context);
                          }),),
                          Expanded(child: AppText(text: '任务中心',fonSize: 20,color: AppColors.whiteColor,)),
                          SizedBox(width: 48,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(height: 40.0,width: double.infinity,child: AppButton(
                        alignment: Alignment.centerLeft,mainAxisAlignment: MainAxisAlignment.start,buttonType: ButtonType.leftImage,
                          title: '注意事项',image: '任务中心注意事项',textStyle: TextStyles.getWhiteBoldText(15), onPress: (){}
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextContainer(title: '1.本周任务不达标,下周将不能兑换优推', height: 25, style: TextStyles.whiteAnd14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextContainer(title: '2.本月任务不达标,扣除代驾分3分', height: 25, style: TextStyles.whiteAnd14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextContainer(title: '3.新入职第一个月不考核月任务,第一周不考试周任务', height: 25, style: TextStyles.whiteAnd14),
                    ),
                  ],
                )
              ],
            ),
          ), 210.0)),
          SliverToBoxAdapter(
            child: Container(
              height: 100.0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        setState(() {
                          mSelected=0;
                        });
                      },
                      child: Container(
                        width: 120.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),bottomLeft:Radius.circular(40.0)),
                            border: Border.all(color: AppColors.mainColor,width: 1),
                            color: mSelected==0?AppColors.mainColor:AppColors.whiteColor
                        ),
                        child: AppText(text: '本周任务',color: mSelected==0?AppColors.whiteColor:AppColors.mainColor,),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          mSelected=1;
                        });
                      },
                      child: Container(
                        width: 120.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(40.0),bottomRight:Radius.circular(40.0)),
                            border: Border.all(color: AppColors.mainColor,width: 1),
                            color: mSelected==1?AppColors.mainColor:AppColors.whiteColor
                        ),
                        child: AppText(text: '本月任务',color: mSelected==1?AppColors.whiteColor:AppColors.mainColor,),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 50.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    alignment: Alignment.centerLeft,
                    child: LoadAssetImage('任务中心',radius: 0.0,height: 10,fit: BoxFit.fitHeight,),
                  ),
                  TextContainer(title: '本周任务(未完成)', height: 30.0, style: TextStyles.mainAnd14)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              padding: EdgeInsets.only(top: 16,bottom: 16),
              child: Column(
                children: <Widget>[
                  createContainer(),
                  createContainer(),
                  createContainer(),
                  createContainer(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 50.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    alignment: Alignment.centerLeft,
                    child: LoadAssetImage('任务中心',radius: 0.0,height: 10,fit: BoxFit.fitHeight,),
                  ),
                  TextContainer(title: '上周任务完成情况(未完成)', height: 30.0, style: TextStyles.mainAnd14)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  createContainer(){
    return ContainerAddLineWidget(
      edgeInsets: EdgeInsets.only(top: 5,bottom: 5),
      height: 60.0,
        child: Column(
          children: <Widget>[
            AppCell(title: '本周总订单任务', content: '未完成',height: 20.0,),
            AppCell(height: 20.0,title: '推荐新客扫码开单或者扫码领红包',titleStyle: TextStyles.textDarkGray12, content: '2/2',contentStyle: TextStyles.textDarkGray12,),
          ],
        )
    );
  }
}


class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
