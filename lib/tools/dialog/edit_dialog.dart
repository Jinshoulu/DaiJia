
import 'package:flutter/material.dart';

import '../../public_header.dart';
import 'base_dialog.dart';

/*
示例
 showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return GoodsSizeDialog(
                      onPressed: (name) {
                        setState(() {
                          _sizeName = name;
                          _isEdit = true;
                        });
                      },
                    );
                  }
                );
 */
/// design/4商品/index.html#artboard10
class EditDialog extends StatefulWidget {

  EditDialog({
    Key key,
    this.onPressed,
    this.title = '标题',
    this.hintText = '请输入内容...',
  }) : super(key : key);

  final Function(String) onPressed;
  final String title;
  final String hintText;

  @override
  _EditDialog createState() => _EditDialog();

}

class _EditDialog extends State<EditDialog> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Container(
        height: 34.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: ThemeUtils.getDialogTextFieldColor(context),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          autofocus: true,
          controller: _controller,
          maxLines: 1,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: InputBorder.none,
            hintText: widget.hintText,
            //hintStyle: TextStyles.textGrayC14,
          ),
        ),
      ),
      onPressed: () {
        AppPush.goBack(context);
        widget.onPressed(_controller.text);
      },
    );
  }
}