
import 'package:flutter/material.dart';

import '../../public_header.dart';

class AppRefreshWidget extends StatefulWidget {

  final Function requestBackData;
  final Map requestData;
  final String requestUrl;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;

  const AppRefreshWidget({
    Key key,
    @required this.itemBuilder,
    @required this.requestData,
    @required this.requestUrl,
    @required this.requestBackData,
    this.stateType = StateType.empty,
  }) : super(key: key);

  @override
  _AppRefreshWidgetState createState() => _AppRefreshWidgetState();
}

class _AppRefreshWidgetState extends State<AppRefreshWidget> {

  EasyRefreshController _controller;
  List _list = ['','','','',];
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  int _maxPage = 1;
  StateType _stateType = StateType.loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    _onRefresh();

  }

  Future _onRefresh() async {
    _page = 1;
    getData();
  }

  getData(){
    var data = widget.requestData;
    data['page'] = _page;
    DioUtils.instance.post(widget.requestUrl, needList: true, data: data, onFailure: (code,msg){
      if(mounted){
        setState(() {
          _isLoading = false;
          _stateType = widget.stateType;
          widget.requestBackData(_list);
        });
      }
    },onSucceed: (response){
      List list = response['data'];
      _maxPage = response['countPage'];
      showDataList(list);
    });
  }

  showDataList(List dataList) {
    if (_page == 1) {
      _list.clear();
    }
    _list.addAll(dataList);
    if(mounted){
      setState(() {
        _isLoading = false;
        if (_list.length == 0) {
          _stateType = widget.stateType;
        }
        widget.requestBackData(_list);
      });
    }
  }

  Future _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      setState(() {
        _isLoading = false;
        _controller.finishLoad(success: true, noMore: true);
      });
      return;
    }
    _isLoading = true;
    _page++;
    getData();
  }

  bool _hasMore() {
    return _page < _maxPage;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        controller: _controller,
        onRefresh: ()async{
          _onRefresh();
        },
        onLoad: ()async{
          _loadMore();
        },
        child: _list.length == 0 ? Container(
            height: MediaQuery.of(context).size.height-50,child: StateLayout(type: _isLoading?StateType.loading:widget.stateType))
            : ListView.builder(
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              /// 不需要加载更多则不需要添加FootView
              return widget.itemBuilder(context, index);
            }
        )
    );
  }
}
