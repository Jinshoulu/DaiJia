
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/refresh/app_refresh_state.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'mine_single_item.dart';

class MineSendSingle extends StatefulWidget {
  @override
  _MineSendSingleState createState() => _MineSendSingleState();
}

class _MineSendSingleState extends State<MineSendSingle> {

  List dataList = [];
  int page= 1;
  int maxPage = 1;
  StateType _stateType = StateType.loading;
  EasyRefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = EasyRefreshController();
    getData();
  }

  getData(){
    Future.delayed(Duration(seconds: 3)).then((value){
      setState(() {
        dataList.add('value');
        dataList.add('value');
        dataList.add('value');
        dataList.add('value');
        _stateType = StateType.empty;
      });
    });
  }

  Future onRefresh()async{
    page=1;
    getData();
  }
  Future _loadMore() async {
    if (_stateType == StateType.loading) {
      return;
    }
    if (!_hasMore()) {
      setState(() {
        _refreshController.finishLoad(success: true, noMore: true);
      });
      return;
    }
    page++;
    getData();
  }

  bool _hasMore() {
    return page < maxPage;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowWhiteAppBar(
        centerTitle: '我派的单',
      ),
      body: dataList.isEmpty?showEmpty():
      EasyRefresh(
              onRefresh: () async {
                onRefresh();
              },
              onLoad: () async {
                _loadMore();
              },
          controller: _refreshController,
              child: ListView.builder(
                  itemCount: dataList.length,
                  addSemanticIndexes: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      color: AppColors.whiteColor,
                      child: StickyHeader(
                          header: Container(
                            padding: EdgeInsets.only(left: 16,right: 16),
                            height: 45.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                ),
                                SizedBox(width: 10,),
                                TextContainer(
                                    title: '12月28日',
                                    height: 45,
                                    style: TextStyle(
                                        fontSize: 15, color: AppColors.mainColor,fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          content: createSubItem(['', ''])),
                    );
                  })),
    );
  }

  createSubItem(List data){
    List<Widget> list = List.generate(data.length, (index){
      return MineSingleItem(
        title: '订单',
        time: '12：12',
        showCancel: true,
        onPress: (){
          AppShowBottomDialog.showNormalDialog(this.context,'确定取消','再等等','派单取消', '我们会在预约的时间前为您妥善安排的\n确定取消吗?', (){

          });
        },
      );
    });
    return Column(
      children: list,
    );
  }

  showEmpty(){
    return Container(height: MediaQuery.of(context).size.height-50,child: StateLayout(type: _stateType));
  }
}
