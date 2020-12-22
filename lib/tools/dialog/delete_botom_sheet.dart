
import 'package:flutter/material.dart';
import '../../public_header.dart';

/*
示例
 void _showDeleteBottomSheet(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DeleteBottomSheet(
          onTapDelete: () {
            setState(() {
              _list.removeAt(index);
              if (_list.isEmpty) {
                _stateType = StateType.goods;
              }
            });
            _setGoodsCount(_list.length);
          },
        );
      },
    );
  }
 */
/// design/4商品/index.html#artboard2
class DeleteBottomSheet extends StatelessWidget {


  const DeleteBottomSheet({
    Key key,
    @required this.onTapDelete, this.title = '是否确认删除，防止错误操作', this.tips = '确认删除',
  }): super(key: key);

  final Function onTapDelete;
  final String title;
  final String tips;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 52.0,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: Dimens.font_sp14,color: Colors.black),
                ),
              ),
            ),
            Gaps.line,
            SizedBox(
              height: 54.0,
              width: double.infinity,
              child: FlatButton(
                textColor: Theme.of(context).errorColor,
                child: Text(tips, style: TextStyle(fontSize: Dimens.font_sp18)),
                onPressed: () {
                  AppPush.goBack(context);
                  onTapDelete();
                },
              ),
            ),
            Gaps.line,
            SizedBox(
              height: 54.0,
              width: double.infinity,
              child: FlatButton(
                textColor: AppColors.text_gray,
                child: const Text('取消', style: TextStyle(fontSize: Dimens.font_sp18)),
                onPressed: () {
                  AppPush.goBack(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}