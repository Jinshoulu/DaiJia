import 'dart:math';

import 'package:flutter/material.dart';

class Ani4 extends StatefulWidget {
  @override
  _Ani4State createState() => _Ani4State();
}

class _Ani4State extends State<Ani4> {
  double num=0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('animateOpacity'),
      ),
      body:AnimatedPadding(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.only(top:num),
        curve: Curves.bounceOut,
        child: Container(
            height: 300,
            width: 300,
            color: Colors.blue,
            child: Text('$num'),
          ),
      ),
//      AnimatedOpacity(
//        opacity: num,
//        duration: Duration(seconds: 1),
//        curve:Curves.bounceInOut,
//        child: Container(
//          height: 300,
//          width: 300,
//          color: Colors.blue,
//          child: Text('$num'),
//        ),
//      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '111',
        onPressed: (){
          setState(() {
//            num=Random().nextDouble();
          num==0?num=100.0:num=0.0;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
