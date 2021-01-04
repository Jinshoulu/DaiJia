
import 'package:demo/z_tools/app_widget/load_image.dart';
import 'package:demo/z_tools/bar/app_white_bar.dart';
import 'package:flutter/material.dart';

class RewardSystem extends StatefulWidget {
  @override
  _RewardSystemState createState() => _RewardSystemState();
}

class _RewardSystemState extends State<RewardSystem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '奖励机制',
      ),
      body: Container(
        width: double.infinity,
        child: LoadImage('',radius: 0.0,),
      ),
    );
  }
}
