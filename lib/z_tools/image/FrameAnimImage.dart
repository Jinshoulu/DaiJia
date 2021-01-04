import 'dart:async';

import 'package:flutter/material.dart';

class FrameAnimImage extends StatefulWidget {
  final List<String> imagePaths;
  final int interval;
  final String defaultImage;
  const FrameAnimImage({
    Key key,
    this.imagePaths,
    this.interval: 200, this.defaultImage,
  }) : super(key: key);

  @override
  _FrameAnimImageState createState() => _FrameAnimImageState();
}

class _FrameAnimImageState extends State<FrameAnimImage> {
  List<Widget> images = new List();
  Timer mTimer;
  int mCurrentIndex = 0;

  @override
  void initState() {
    widget?.imagePaths?.forEach((element) {
      images.add(
        new Image.asset(
          element,
          width: 22,
          height: 22,
          gaplessPlayback: true,
        ),
      );
    });
    super.initState();
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (images.length > 0) {
      mCurrentIndex = images.length - 1;
    } else {
      mCurrentIndex = 0;
    }
    mTimer?.cancel();
    mTimer = null;
    super.dispose();
  }

  void startTimer() {
    if (mTimer != null) {
      mTimer.cancel();
      mTimer = null;
    }
    mCurrentIndex = 0;
    mTimer = Timer.periodic(Duration(milliseconds: widget?.interval), (timer) {
      if (mounted) {
        mCurrentIndex++;
        if (mCurrentIndex < images.length) {
          if (mounted) {
            setState(() {});
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return mCurrentIndex < images?.length
        ? images[mCurrentIndex]
        : new Image.asset(
            widget?.defaultImage,
            width: 22,
            height: 22,
            gaplessPlayback: true,
          );
  }
}
