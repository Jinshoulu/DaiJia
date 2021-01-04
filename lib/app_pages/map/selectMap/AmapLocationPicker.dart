

import 'dart:async';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../public_header.dart';
import 'PoiInfo.dart';
import 'SearchBar.dart';


const _iconSize = 50.0;
const _indicator = 'assets/images/indicator.png';
double _fabHeight = 16.0;

typedef Future<bool> RequestPermission();
typedef Widget PoiItemBuilder(Poi poi, bool selected);

class AmapLocationPicker extends StatefulWidget {
  const AmapLocationPicker({
    Key key,
    @required this.requestPermission,
    @required this.poiItemBuilder,
    this.zoomLevel = 16.0,
    this.zoomGesturesEnabled = false,
    this.showZoomControl = false,
    this.centerIndicator,
    this.enableLoadMore = true,
    this.onItemSelected,
  })  : assert(zoomLevel != null && zoomLevel >= 3 && zoomLevel <= 19),
        super(key: key);

  /// 请求权限回调
  final RequestPermission requestPermission;

  /// Poi列表项Builder
  final PoiItemBuilder poiItemBuilder;

  /// 显示的缩放登记
  final double zoomLevel;

  /// 缩放手势使能 默认false
  final bool zoomGesturesEnabled;

  /// 是否显示缩放控件 默认false
  final bool showZoomControl;

  /// 地图中心指示器
  final Widget centerIndicator;

  /// 是否开启加载更多
  final bool enableLoadMore;

  /// 选中回调
  final Function(PoiInfo,bool) onItemSelected;

  @override
  _AmapLocationPickerState createState() => _AmapLocationPickerState();
}

class _AmapLocationPickerState extends State<AmapLocationPicker>
    with SingleTickerProviderStateMixin, _BLoCMixin, _AnimationMixin {
  // 地图控制器
  AmapController _controller;
  final PanelController _panelController = PanelController();

  // 是否用户手势移动地图
  bool _moveByUser = true;

  // 当前请求到的poi列表
  List<PoiInfo> _poiInfoList = [];

  // 当前地图中心点
  LatLng _currentCenterCoordinate;

  // 页数
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    final minPanelHeight = MediaQuery.of(context).size.height * 0.4;
    final maxPanelHeight = MediaQuery.of(context).size.height * 0.7;
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ShowWhiteAppBar(
        centerTitle: '我要派单',
        rightWidget: AppButton(title: '我派的单', image: null, onPress:(){

        }),
      ),
      body: SlidingUpPanel(
        controller: _panelController,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        minHeight: minPanelHeight,
        maxHeight: maxPanelHeight,
        borderRadius: BorderRadius.circular(8),
        onPanelSlide: (double pos) => setState(() {
          _fabHeight = pos * (maxPanelHeight - minPanelHeight) * .5 + 16;
        }),
        body: Column(
          children: <Widget>[
            Flexible(
              child: Stack(
                children: <Widget>[
                  AmapView(
                    mapType: ThemeUtils.isDark(context) ? MapType.Night : null,
                    zoomLevel: widget.zoomLevel,
                    zoomGesturesEnabled: widget.zoomGesturesEnabled,
                    showZoomControl: widget.showZoomControl,
                    autoRelease: false,
                    onMapMoveEnd: (move) async {
                      if (_moveByUser) {
                        // 地图移动结束, 显示跳动动画
                        _jumpController
                            .forward()
                            .then((it) => _jumpController.reverse());
                        _search(move.latLng);
                      }
                      _moveByUser = true;
                      // 保存当前地图中心点数据
                      _currentCenterCoordinate = move.latLng;
                    },
                    onMapCreated: (controller) async {
                      _controller = controller;
                      if (await widget.requestPermission()) {
                        await _showMyLocation();
                        _search(await _controller.getLocation());
                      } else {
                        debugPrint('权限请求被拒绝!');
                      }
                    },
                  ),
                  // 中心指示器
                  Center(
                    child: AnimatedBuilder(
                      animation: _tween,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            _tween.value.dx,
                            _tween.value.dy - _iconSize / 2,
                          ),
                          child: child,
                        );
                      },
                      child: widget.centerIndicator ??
                          Image.asset(
                            _indicator,
                            height: _iconSize,
                          ),
                    ),
                  ),
                  // 定位按钮
                  Positioned(
                    right: 16.0,
                    top: 16,
                    child: FloatingActionButton(
                      child: StreamBuilder<bool>(
                        stream: _onMyLocation.stream,
                        initialData: true,
                        builder: (context, snapshot) {
                          return Icon(
                            Icons.gps_fixed,
                            color: snapshot.data
                                ? Theme.of(context).primaryColor
                                : Colors.black54,
                          );
                        },
                      ),
                      onPressed: _showMyLocation,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // 用来抵消panel的最小高度
            SizedBox(height: minPanelHeight),
          ],
        ),
        panelBuilder: (scrollController) {
          return StreamBuilder<List<PoiInfo>>(
            stream: _poiStream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return EasyRefresh(
                  enableControlFinishRefresh: false,
                 onLoad: widget.enableLoadMore ? _handleLoadMore : null,

//                  enablePullDown: false,
//                  onLoading: widget.enableLoadMore ? _handleLoadMore : null,
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                            height: 70,
                            padding: EdgeInsets.only(left: 16,right: 16),
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 45.0,
                              child: new SearchBar(
                                bgColor: AppColors.bgColor,
                                onClear: () {},
                                onSubmitted: (str) async {
                                  print(str);
                                  if (str.toString().isNotEmpty) {
                                    List<Poi> poiList = await  AmapSearch.instance.searchKeyword(str);
                                    if (poiList.length > 0) {
                                      _poiInfoList = poiList.map((poi) => PoiInfo(poi)).toList();
                                      // 设置地图中心点
                                      _setCenterCoordinate(_poiInfoList[0].poi.latLng);
                                      // 默认勾选第一项
                                      if (_poiInfoList.isNotEmpty) _poiInfoList[0].selected = true;
                                      _poiStream.add(_poiInfoList);
                                      // 重置页数
                                      _page = 1;
                                    } else {
                                      Toast.show("未找到相关位置！");
                                    }
                                  }
                                },
                              ),
                            )),
                      ),
                      SliverList(delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                        final poi = data[index].poi;
                        final selected = data[index].selected;
                          return GestureDetector(
                            onTap: () {
                              // 遍历数据列表, 设置当前被选中的数据项
                              for (int i = 0; i < data.length; i++) {
                                data[i].selected = i == index;
                              }
                              // 如果索引是0, 说明是当前位置, 更新这个数据
                              _onMyLocation.add(index == 0);
                              // 刷新数据
                              _poiStream.add(data);
                              // 设置地图中心点
                              _setCenterCoordinate(poi.latLng);
                              // 回调
                              if (widget.onItemSelected != null) {
                                widget.onItemSelected(data[index],false);
                              }
                            },
                            child: widget.poiItemBuilder(poi, selected),
                          );
                        },childCount: data?.length
                      ))
                    ],
                  ),
                );
              } else {
                return Center(child: CupertinoActivityIndicator());
              }
            },
          );
        },
      ),
    );
  }

//  createListView(){
//    return ListView.builder(
//      padding: EdgeInsets.zero,
//      controller: scrollController,
//      itemCount: data?.length,
//      itemBuilder: (context, index) {
//        final poi = data[index].poi;
//        final selected = data[index].selected;
//        return GestureDetector(
//          onTap: () {
//            // 遍历数据列表, 设置当前被选中的数据项
//            for (int i = 0; i < data.length; i++) {
//              data[i].selected = i == index;
//            }
//            // 如果索引是0, 说明是当前位置, 更新这个数据
//            _onMyLocation.add(index == 0);
//            // 刷新数据
//            _poiStream.add(data);
//            // 设置地图中心点
//            _setCenterCoordinate(poi.latLng);
//            // 回调
//            if (widget.onItemSelected != null) {
//              widget.onItemSelected(data[index],false);
//            }
//          },
//          child: widget.poiItemBuilder(poi, selected),
//        );
//      },
//    );
//  }

  searchBar(){
    return AppBar(
      titleSpacing: 0,
      leading: new IconButton(
        icon: new Icon(
          CupertinoIcons.left_chevron,
          color: ThemeUtils.isDark(context)?AppColors.whiteColor:AppColors.blackColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Container(
          child: new SearchBar(
            onClear: () {},
            onSubmitted: (str) async {
              print(str);
              if (str.toString().isNotEmpty) {
                List<Poi> poiList = await  AmapSearch.instance.searchKeyword(str);
                if (poiList.length > 0) {
                  _poiInfoList = poiList.map((poi) => PoiInfo(poi)).toList();
                  // 设置地图中心点
                  _setCenterCoordinate(_poiInfoList[0].poi.latLng);
                  // 默认勾选第一项
                  if (_poiInfoList.isNotEmpty) _poiInfoList[0].selected = true;
                  _poiStream.add(_poiInfoList);
                  // 重置页数
                  _page = 1;
                } else {
                  Toast.show("未找到相关位置！");
                }
              }
            },
          )),
      centerTitle: true,
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              if (_poiInfoList != null) {
                for (int i = 0; i < _poiInfoList.length; i++) {
                  if (_poiInfoList[i].selected) {
                    widget.onItemSelected(_poiInfoList[i],true);
                    break;
                  }
                }
              }
            },
            child: new Text("发送")),
      ],
    );
  }

  Future<void> _search(LatLng location) async {
    final poiList = await  AmapSearch.instance.searchAround(location);
    _poiInfoList = poiList.map((poi) => PoiInfo(poi)).toList();
    // 默认勾选第一项
    if (_poiInfoList.isNotEmpty) _poiInfoList[0].selected = true;
    _poiStream.add(_poiInfoList);
    // 重置页数
    _page = 1;
  }

  Future<void> _showMyLocation() async {
    _onMyLocation.add(true);
    await _controller?.showMyLocation(MyLocationOption(
      strokeColor: Colors.transparent,
      fillColor: Colors.transparent,
    ));
  }

  Future<void> _setCenterCoordinate(LatLng coordinate) async {
    await _controller.setCenterCoordinate(coordinate);
    _moveByUser = false;
  }

  Future<void> _handleLoadMore() async {
    final poiList = await  AmapSearch.instance.searchAround(
      _currentCenterCoordinate,
      page: ++_page,
    );
    _poiInfoList.addAll(poiList.map((poi) => PoiInfo(poi)).toList());
    _poiStream.add(_poiInfoList);
  }
}

mixin _BLoCMixin on State<AmapLocationPicker> {
  // poi流
  final _poiStream = StreamController<List<PoiInfo>>();

  // 是否在我的位置
  final _onMyLocation = StreamController<bool>();

  @override
  void dispose() {
    _poiStream.close();
    _onMyLocation.close();
    super.dispose();
  }
}

mixin _AnimationMixin on SingleTickerProviderStateMixin<AmapLocationPicker> {
  // 动画相关
  AnimationController _jumpController;
  Animation<Offset> _tween;

  @override
  void initState() {
    super.initState();
    _jumpController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _tween = Tween(begin: Offset(0, 0), end: Offset(0, -15)).animate(
        CurvedAnimation(parent: _jumpController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _jumpController?.dispose();
    super.dispose();
  }
}

