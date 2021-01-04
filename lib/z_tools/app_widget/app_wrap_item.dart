
import 'package:flutter/material.dart';

import '../../public_header.dart';

//String 标签自动换行

class AppWrapItem extends StatelessWidget {

  final List chipList;
  final TextStyle style;
  final double crossSpace;
  final double mainSpace;
  final Function onPress;

  const AppWrapItem({
    Key key,
    @required this.chipList,
    this.style,
    this.crossSpace = 8.0,  //一行中两个chip的间距，当不设置时，自动调整间隔
    this.mainSpace = 2.0,  //两行之间的间距
    this.onPress,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(//自动换行
            spacing: crossSpace,
            runSpacing: mainSpace,
            children: createChipList(),
          )
        ],
      ),
    );
  }

  createChipList(){

    List<Widget> list = List();
    for(int i = 0; i<chipList.length; i++){
      list.add(createChipOne(chipList[i],i));
    }
    return list;
  }

  //默认标签
  createChipOne(String title,int index){
    return InkWell(
      onTap: (){
        onPress(index);
      },
      child: Chip(
          label: Text(title,style: style??TextStyle(
              fontSize: Dimens.font_sp14,
              color: AppColors.blackColor
          ),),
        backgroundColor: AppColors.bgColor,
      ),
    );
  }
  //自定义背景色
  createChipTwo(String title,Color bgColor){
    return Chip(
        label: Text(title,style: style??TextStyle(
            fontSize: Dimens.font_sp14,
            color: AppColors.blackColor
        ),),
        backgroundColor: bgColor,
    );
  }
  //自定义标签
  createChipThree(String title){
    return Chip(
      label: Text(title,style: style??TextStyle(
          fontSize: Dimens.font_sp14,
          color: AppColors.blackColor
      ),),
      avatar: CircleAvatar(
        backgroundColor:Colors.grey,
        child:Text('素'),
      ),
    );
  }
  //网络图片
  createChipFour(String title){
    return Chip(
      label: Text(title,style: style??TextStyle(
          fontSize: Dimens.font_sp14,
          color: AppColors.blackColor
      ),),
      avatar: CircleAvatar(
        backgroundImage:NetworkImage('https://resources.ninghao.org/images/wanghao.jpg'),
      ),
    );
  }
}
