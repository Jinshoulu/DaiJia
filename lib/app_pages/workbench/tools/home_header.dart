
import 'package:demo/app_pages/workbench/beans/HomeInfoBean.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';




class HomeHeader extends StatelessWidget {

  final int type;
  final HomeInfoBean bean;
  final Function onPress;

  const HomeHeader({Key key,@required this.bean, this.type = 0, this.onPress}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      height: 50.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          createExpand('公司公告', 0,type==0?true:false),
          SizedBox(width: 30,),
          createExpand('返现提醒', bean?.dmoney_count??0,type==1?true:false),
          SizedBox(width: 30,),
          createExpand('订单提醒', bean?.dorder_count??0,type==2?true:false),
          Expanded(child: SizedBox()),
          type!=0?SizedBox(
              width: 70,
              child: AppButton(title: '查看更多',textStyle: TextStyles.blackAnd12, onPress:(){
                onPress('查看更多');
              }),
          ):SizedBox()
        ],
      ),
    );
  }

  createExpand(String title, int number,bool select){
    return InkWell(
      onTap: (){
        onPress(title);
      },
      child: Container(
        width: 70,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: TextContainer(
                    alignment: Alignment.center,
                    title: title,
                    height: 40,
                    style: select?TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor
                    ):TextStyle(
                        fontSize: 13,
                        color: AppColors.blackColor
                    )
                )
            ),
            Positioned(left:10, right: 10,bottom: 0,child: Container(
              height: 3,decoration: BoxDecoration(
                color: select?AppColors.mainColor:Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(4))
            ),)),
            Positioned(
                top: 5,
                right: 10,
                child: number>0?Container(
                  alignment: Alignment.center,
                  height: 15,
                  width: 15,
                  child: Text(
                    number.toString(),
                    style: TextStyle(fontSize: 10, color: AppColors.whiteColor),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ):SizedBox()
            )
          ],
        ),
      ),
    );
  }
}
