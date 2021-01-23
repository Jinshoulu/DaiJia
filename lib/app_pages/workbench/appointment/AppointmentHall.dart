
import 'package:demo/app_pages/workbench/appointment/AppointmentItem.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class AppointmentHall extends StatefulWidget {
  @override
  _AppointmentHallState createState() => _AppointmentHallState();
}

class _AppointmentHallState extends State<AppointmentHall>  with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  TabController _tabController ;
  
  EasyRefreshController _controller;
  List _list = ['','','','',];
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  int _maxPage = 1;
  StateType _stateType = StateType.loading;

  //不显示已配送
  bool showPushed = false;
  int dataType = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    _tabController = new TabController(length: 3, vsync: this);

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
    super.build(context);

    return AppStackWidget(
        isUp: true,
        height: 60.0,
        topWidget: Container(
          color: AppColors.whiteColor,
          margin: EdgeInsets.only(top: 10.0),
          height: 50.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: AppColors.mainColor,
                    labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    indicatorWeight: 2.0,
                    labelPadding: EdgeInsets.symmetric(horizontal: 0),
                    unselectedLabelColor: AppColors.blackColor,
                    unselectedLabelStyle: TextStyle(fontSize: 13),
                    onTap: (index) {
                      dataType = index;
                      _onRefresh();
                    },
                    tabs: <Widget>[
                      Tab(text: '全部',),
                      Tab(text: '距离',),
                      Tab(text: '时间',),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 100,),
              Container(
                width: 150.0,
                child: AppButton(title: '不显示已派送单',image: showPushed?'橙色已选择':'橙色未选择',
                    imageSize: 15.0,
                    buttonType: ButtonType.leftImage,
                    textStyle: TextStyle(fontSize: 12,color: AppColors.orangeColor),
                    onPress: (){
                  setState(() {
                    showPushed=!showPushed;
                  });
                }),
              )
            ],
          ),
        ),
        downWidget: EasyRefresh(
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
                  return AppointmentItem(
                    data: {},
                  );
                }
            )
        )
    );
  }
}
