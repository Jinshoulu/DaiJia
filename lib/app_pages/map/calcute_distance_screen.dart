import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';

class CalculateDistanceScreen extends StatefulWidget {
  @override
  CalculateDistanceStateScreen createState() => CalculateDistanceStateScreen();
}

class CalculateDistanceStateScreen extends State<CalculateDistanceScreen> {
  final _point1LatController = TextEditingController(text: '34.777398');
  final _point1LngController = TextEditingController(text: '113.707818');
  final _point2LatController = TextEditingController(text: '34.777398');
  final _point2LngController = TextEditingController(text: '113.708996');

  //latLng: 34.777398, 113.707818,
  double _result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('距离计算'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 60.0,
            child: Row(
              children: <Widget>[
                Text('点1:'),
                Flexible(
                  child: TextFormField(
                    controller: _point1LatController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '输入点1纬度'),
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: _point1LngController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '输入点1经度'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            child: Row(
              children: <Widget>[
                Text('点2:'),
                Flexible(
                  child: TextFormField(
                    controller: _point2LatController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '输入点2纬度'),
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: _point2LngController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: '输入点2经度'),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () async {
              final result = await AmapService.instance.calculateDistance(
                LatLng(
                  double.parse(_point1LatController.text),
                  double.parse(_point1LngController.text),
                ),
                LatLng(
                  double.parse(_point2LatController.text),
                  double.parse(_point2LngController.text),
                ),
              );
              setState(() => _result = result);
            },
            child: Text('计算'),
          ),
          Text(_result.toString() + '米'),
        ],
      ),
    );
  }
}
