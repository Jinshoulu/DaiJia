
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class ChangeRecord extends StatefulWidget {
  @override
  _ChangeRecordState createState() => _ChangeRecordState();
}

class _ChangeRecordState extends State<ChangeRecord> {

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
    var data = {};
    data['page'] = _page;
    DioUtils.instance.post(Api.baseApi, needList: true, data: data, onFailure: (code,msg){
      if(mounted){
        setState(() {
          _isLoading = false;
          _stateType = StateType.empty;
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
          _stateType = StateType.empty;
        }
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
            height: MediaQuery.of(context).size.height-50,child: StateLayout(type: _isLoading?StateType.loading:_stateType))
            : ListView.builder(
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              /// 不需要加载更多则不需要添加FootView
              return ContainerAddLineWidget(
                height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppCell(title: '兑换时间',height: 25, content: '2020.01.04 12:12',contentStyle: TextStyles.blackAnd14,),
                      AppCell(title: '类型',height: 25, content: '2小时',contentStyle: TextStyles.mainAnd14,),
                    ],
                  )
              );
            }
        )
    );
  }
}
