
import 'package:demo/tools/res/utils.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../public_header.dart';


class KeyboardActionWidget extends StatefulWidget {

  final List<FocusNode> list;
  final Widget child;
  const KeyboardActionWidget({
    Key key,
    @required this.list,
    @required this.child
  }) : super(key: key);


  @override
  _KeyboardActionWidgetState createState() => _KeyboardActionWidgetState();
}

class _KeyboardActionWidgetState extends State<KeyboardActionWidget> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS?KeyboardActions(
        config: Utils.getKeyboardActionsConfig(context, widget.list),
        child: widget.child,
    ):widget.child;
  }
}
