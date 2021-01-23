import 'dart:math';

import 'package:flutter/material.dart';

class Ani5 extends StatefulWidget {
  @override
  _Ani5State createState() => _Ani5State();
}

class _Ani5State extends State<Ani5> {
  double left = 0.0;
  double end = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ani5'),
        ),
        body: Center(
          child: TweenAnimationBuilder(
            onEnd: (){
              print('动画结束');
            },
            duration: Duration(seconds: 1),
            tween: Tween(begin: 0.0, end: end),
            builder: (BuildContext context, double value, Widget child) {
              return Container(
                padding: EdgeInsets.only(left: 0),
                height: 300,
                width: 300,
                color: Colors.blue,
                child: Transform.translate(
                  offset: Offset(value,10),
                  child: Transform.rotate(
                    angle: 0,
                    child: Transform.scale(
                      scale: 1,
                      child: Text(
                        '$end',
//                  style: TextStyle(fontSize: value),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: '111',
          onPressed: () {
            setState(() {
             end=Random().nextDouble()*100;
            });
          },
          child: Icon(Icons.add),
        ));
  }
}
