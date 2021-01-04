
import 'package:flutter/material.dart';

class AppEditDetailWidget extends StatelessWidget {

  final TextEditingController editingController;
  final FocusNode focusNode;
  final Color bgColor;
  final String hintText;
  final Color bordSideColor;
  final EdgeInsets edgeInsets;
  final double height;
  final double radius;
  final Function onChange;
  const AppEditDetailWidget({
    Key key,
    @required this.editingController,
    @required this.focusNode,
    @required this.bgColor,
    @required this.hintText,
    @required this.bordSideColor,
    @required this.onChange,
    this.edgeInsets,
    this.height = 120.0, this.radius = 8.0,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets??EdgeInsets.only(left: 0,right: 0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: bordSideColor,width: 0.8)
      ),
      height: height,
      child: TextField(
        controller: editingController,
        focusNode: focusNode,
        onSubmitted: (result) {
          focusNode.unfocus();
        },
        onChanged: onChange,
        maxLines: 5,
//        maxLength: 200,
        decoration: new InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderSide: BorderSide.none)
        ),
      ),
    );
  }
}
