
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

class OrderNoticeList extends StatefulWidget {
  @override
  _OrderNoticeListState createState() => _OrderNoticeListState();
}

class _OrderNoticeListState extends State<OrderNoticeList> {

  EasyRefreshController _controller;
  List _list = [];
  /// 是否正在加载数据
  bool _isLoading = true;
  int _page = 1;
  int _maxPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    _onRefresh();

  }

  Future _onRefresh() async {
    _page = 1;
    getDetailInfoData();
  }
  //获取数据
  getDetailInfoData(){
    DioUtils.instance.post(Api.mineOrderTipsUrl, onFailure: (code,msg){
      reloadState();
    },onSucceed: (response){
      if(response is Map){
        if(response['list']!=null){
          if(response['list'] is Map){
            var data = response['list'];
            if(data['list'] is List){
              showDataList(data['list']);
            }else{
              Toast.show('返回的数据类型有问题，请联系后台');
              reloadState();
            }
          }else{
            Toast.show('返回的数据类型有问题，请联系后台');
            reloadState();
          }
        }else{
          Toast.show('返回的数据类型有问题，请联系后台');
          reloadState();
        }
      }else{
        reloadState();
      }
    });
  }

  reloadState(){
    if(mounted){
      setState(() {
        _isLoading = false;
      });
    }
  }


  showDataList(List dataList) {
    if (_page == 1) {
      _list.clear();
    }
    _list.addAll(dataList);
    reloadState();
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
    getDetailInfoData();
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
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: ShowWhiteAppBar(
          isReload: true,
          centerTitle: '订单提醒',
        ),
        body: EasyRefresh(
          controller: _controller,
          onLoad: ()async{
            _loadMore();
          },
          onRefresh: ()async{
            _onRefresh();
          },
          child: CustomScrollView(
            slivers: <Widget>[

              _list.isEmpty?
              SliverToBoxAdapter(
                child: Container(
                    height: MediaQuery.of(context).size.height-50.0,child: StateLayout(type: _isLoading?StateType.loading:StateType.empty)
                ),
              ):
              SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                    return Container(
                      margin: EdgeInsets.only(left: 16,right: 16,top: 10),
                      padding: EdgeInsets.only(left: 16,right: 16),
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextContainer(title: AppClass.data(_list[index], 'content'), height: 30.0, style: TextStyles.blackAnd14),
                          TextContainer(title: AppClass.data(_list[index], 'create_time'), height: 15.0, style: TextStyles.timeStyle),
                        ],
                      ),
                    );
                  },childCount: _list.length)
              )
            ],
          ),
        ),
      ),
    );
  }

}
