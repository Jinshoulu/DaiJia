
import 'package:flutter/material.dart';

import '../../public_header.dart';
import 'base_dialog.dart';

class ExitDialog extends StatefulWidget {

  ExitDialog({
    Key key,
  }) : super(key : key);

  @override
  _ExitDialog createState() => _ExitDialog();

}

class _ExitDialog extends State<ExitDialog> {

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '提示',
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text('您确定要退出登录吗？', style: TextStyle(color: Colors.black,fontSize: Dimens.font_sp14)),
      ),
      onPressed: () {
        AppClass.exitApp(context);
      },
    );
  }
}