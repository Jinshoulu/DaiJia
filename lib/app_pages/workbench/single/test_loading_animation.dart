import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';



class LoadingGroup extends StatefulWidget {

  LoadingGroup({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoadingGroupState createState() => _LoadingGroupState();
}

class _LoadingGroupState extends State<LoadingGroup> {
  int _orderNum = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 185, 63, 81),
      appBar: AppBar(
        title: Text("加载组件"),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
        ),
        children: <Widget>[
          wrapOrder(Center(child: LineSpinFadeLoaderIndicator())),//小菊花
          wrapOrder(Center(child: BallBeatIndicator())),
          wrapOrder(Center(child: BallClipRotateMultipleIndicator())),
          wrapOrder(Center(child: BallGridPulseIndicator())),
          wrapOrder(Center(child: LineScaleIndicator())),//音浪
          wrapOrder(Center(child: BallPulseRiseIndicator())),
          wrapOrder(Center(child: BallScaleRippleMultipleIndicator())),
          wrapOrder(Center(child: BallZigZagIndicator())),
          wrapOrder(Center(child: BallScaleIndicator())),
          wrapOrder(Center(child: BallPulseSyncIndicator())),
          wrapOrder(Center(child: BallScaleMultipleIndicator())),
          wrapOrder(Center(child: BallPulseIndicator())),//类似百度加载
          wrapOrder(Center(child: BallClipRotatePulseIndicator())),
          wrapOrder(Center(child: BallGridBeatIndicator())),
          wrapOrder(Center(child: SquareSpinIndicator())),
          wrapOrder(Center(child: BallSpinFadeLoaderIndicator())),//圆点转圈
          wrapOrder(Center(child: BallScaleRippleIndicator())),
          wrapOrder(Center(child: SemiCircleSpinIndicator())),
          wrapOrder(Center(child: LineScalePulseOutIndicator())),//另一种音浪
          wrapOrder(Center(child: BallClipRotateIndicator())),
          wrapOrder(Center(child: PacmanIndicator())),//吃豆豆
          wrapOrder(Center(child: BallRotateIndicator())),
          wrapOrder(Center(child: CubeTransitionIndicator())),
          wrapOrder(Center(child: TriangleSkewSpinIndicator())),
        ],
      ),
    );
  }


  @override
  void didUpdateWidget(LoadingGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      _orderNum = 1;
    }
  }

  Widget wrapContainer(Widget child, [Color backgroundColor = Colors.green]) =>
      Container(color: backgroundColor, child: child);

  Widget wrapOrder(Widget child) => Stack(children: <Widget>[
    child,
    Positioned(
      left: 8,
      bottom: 0,
      child: Text("${_orderNum++}",
          style: TextStyle(color: Colors.white, fontSize: 18)),
    ),
  ]);
}