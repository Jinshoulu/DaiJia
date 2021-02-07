
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

class DriverConsumptionRecord extends StatefulWidget {
  @override
  _DriverConsumptionRecordState createState() => _DriverConsumptionRecordState();
}

class _DriverConsumptionRecordState extends State<DriverConsumptionRecord> {

  EasyRefreshController _controller;
  List _list = [];
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
    DioUtils.instance.post(Api.registerUrl, needList: true, data: data, onFailure: (code,msg){
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
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowWhiteAppBar(
        centerTitle: '消单记录',
      ),
      body: AppStackWidget(
        isUp: true,
          height: 150.0,
          topWidget: Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 10.0),
            height: 140.0,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                LoadAssetImage('报备订单详情背景',radius: 0.0,),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      createHeader(0, '消单量', '2'),
                      createHeader(1, '总接单量', '20'),
                      createHeader(2, '消单率', '2%'),
                    ],
                  ),
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
              child:_list.length == 0 ? Container(
                  height: MediaQuery.of(context).size.height-50,child: StateLayout(type: _isLoading?StateType.loading:_stateType))
                  : ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    return createItem();
                  },
                  itemCount: _list.length,
              )
          )
      ),
    );
  }
  
  createItem(){
    return ContainerAddLineWidget(
      edgeInsets: EdgeInsets.all(0.0),
      disW: 0.0,
      height: 140.0,
        child: Container(
          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: Column(
            children: <Widget>[
              AppCell(
                height: 30.0,
                title: '消单单号', 
                content: '2020202020220-1548-1335',
                contentStyle: TextStyles.blackAnd14,
              ),
              AppCell(
                height: 30.0,
                title: '出发地',
                content: '金成时代9号楼',
                contentStyle: TextStyles.blackAnd14,
              ),
              AppCell(
                height: 30.0,
                title: '订单类型',
                content: '实时单',
                contentStyle: TextStyles.blackAnd14,
              ),
              AppCell(
                height: 30.0,
                title: '消单备注',
                content: '无',
                contentStyle: TextStyles.blackAnd14,
              ),
            ],
          ),
        )
    );
  }

  createHeader(int index, String title, String value){

    Alignment alignment = Alignment.center;
//    switch(index){
////      case 0:{
////        alignment = Alignment.centerLeft;
////      }break;
////      case 1:{
////        alignment = Alignment.center;
////      }break;
////      default:{
////        alignment = Alignment.centerRight;
////      }break;
////    }
    return Expanded(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextContainer(alignment: alignment,title: value, height: 30.0, style: TextStyles.getWhiteBoldText(20)),
        TextContainer(alignment: alignment,title: title, height: 20.0, style: TextStyles.whiteAnd14),
      ],
    ));
  }
}
