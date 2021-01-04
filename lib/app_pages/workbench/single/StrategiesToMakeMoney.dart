
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class StategoesToMakeMoney extends StatefulWidget {
  @override
  _StategoesToMakeMoneyState createState() => _StategoesToMakeMoneyState();
}

class _StategoesToMakeMoneyState extends State<StategoesToMakeMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '赚钱攻略',
      ),
      body: Container(
        width: double.infinity,
        child: LoadImage('',radius: 0.0,),
      ),
    );
  }
}
