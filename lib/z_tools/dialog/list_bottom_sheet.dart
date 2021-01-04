
import 'package:flutter/material.dart';

import '../../public_header.dart';

class ListBottomSheet extends StatelessWidget {

  const ListBottomSheet({
    Key key,
    @required this.onTapDelete,
    this.title = '是否确认删除，防止错误操作',
    this.tips = const ['确认删除'],
  }): super(key: key);

  final Function onTapDelete;
  final String title;
  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: createChildren(context),
        ),
      ),
    );
  }

  createChildren(BuildContext context){
    List<Widget> list = [];
    list.add( SizedBox(
      height: 52.0,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: Dimens.font_sp16,color: Colors.black),
        ),
      ),
    ));
    list.add(Gaps.line);

    for(int i = 0; i<tips.length; i++){
      list.add(SizedBox(
        height: 50.0,
        width: double.infinity,
        child: FlatButton(
          textColor: AppColors.blackColor,
          child: Text(tips[i], style: TextStyle(fontSize: Dimens.font_sp12)),
          onPressed: () {
            print("列表点击索引："+ i.toString());
           Navigator.pop(context);
            onTapDelete(i);
          },
        ),
      ));
      list.add(Gaps.line);
    }

    list.add(SizedBox(
      height: 54.0,
      width: double.infinity,
      child: FlatButton(
        textColor: AppColors.text_gray,
        child: const Text('取消', style: TextStyle(fontSize: Dimens.font_sp18)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ));

    return list;

  }
}