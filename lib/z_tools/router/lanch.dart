//启动页面
import 'dart:async';

import 'package:demo/public_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'application.dart';

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LaunchPageWidget();
  }
}

class LaunchPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LaunchState();
}

class LaunchState extends State<LaunchPageWidget> {
  int _countdown = 5;
  Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startRecordTime();
    print('初始化启动页面');
  }

  @override
  void dispose() {
    super.dispose();
    print('启动页面结束');
    if (_countdownTimer != null && _countdownTimer.isActive) {
      _countdownTimer.cancel();
      _countdownTimer = null;
    }
  }

  void _startRecordTime() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown <= 1) {
          Application.router.navigateTo(context, '/index', replace: true);
          _countdownTimer.cancel();
          _countdownTimer = null;
        } else {
          _countdown -= 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            LoadAssetImage('launch_image',radius: 0.0,),
            Positioned(
              top: 30,
              right: 30,
              child: InkWell(
                onTap: () {
                  AppPush.push(context, LoginRouter.loginPage);
                },
                child: Container(
                  width: 50.0,
                  height: 25,
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.whiteColor,width: 1.0)
                  ),
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: '$_countdown',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                      TextSpan(
                          text: '跳过',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
