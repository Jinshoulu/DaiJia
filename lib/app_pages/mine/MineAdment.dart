
import 'package:demo/app_pages/mine/MineAdmentDetail.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:flutter/material.dart';

class MineAdment extends StatefulWidget {
  @override
  _MineAdmentState createState() => _MineAdmentState();
}

class _MineAdmentState extends State<MineAdment> {
  EasyRefreshController _controller;
  List _list = ['','','','',];
  /// 是否正在加载数据
  bool _isLoading = false;
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
    getData();
  }

  getData(){
    var data = {};
    data['page'] = _page;
    DioUtils.instance.post(Api.baseApi, needList: true, data: data, onFailure: (code,msg){
      if(mounted){
        setState(() {
          _isLoading = false;
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
        centerTitle: '公告列表',
        rightWidget: AppButton(
            title: '平安到家',
            textStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),
            onPress: (){

            }
        ),
      ),
      body: EasyRefresh(
          controller: _controller,
          onRefresh: ()async{
            _onRefresh();
          },
          onLoad: ()async{
            _loadMore();
          },
          child: _list.length == 0 ? Container(
              height: MediaQuery.of(context).size.height-50,
              child: StateLayout(type: _isLoading?StateType.loading:StateType.empty))
              : ListView.builder(
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                return createContainer(index);
              }
          )
      ),
    );
  }

  createContainer(int index){
    String content = '未学习';
    Color color  = AppColors.red;
    switch(index%3){
      case 0:{
        content = '已学习';
        color = AppColors.greenColor;
      }break;
      case 1:{
        content = '学习中';
        color = AppColors.orangeColor;
      }break;
      default:{}break;
    }
    return InkWell(
      onTap: (){
        AppPush.pushDefault(context, MineAdmentDetail(id: '10',));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            ContainerAddLineWidget(
                child: AppCell(
                    title: '08:27 - - 09:54',
                    content: content,
                    contentStyle: TextStyle(fontSize: 14,color: color),
                )
            ),
            Container(
              color: AppColors.whiteColor,
              padding: EdgeInsets.only(left: 16,right: 16),
              constraints: BoxConstraints(
                minHeight: 70.0
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: AppText(
                          text: '罪及客户必须确保家付给其他家人,或者交给警察,不然出现意外,可能回程单责任',
                          alignment: Alignment.centerLeft,
                          color: AppColors.black54Color,
                      )
                  ),
                  Container(
                    width: 20.0,
                    alignment: Alignment.center,
                    child: LoadAssetImage('ic_arrow_right',width: 12,fit: BoxFit.fitWidth,radius: 0.0,),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
