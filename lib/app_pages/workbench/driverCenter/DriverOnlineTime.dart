
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:flutter/material.dart';

import '../../../public_header.dart';

class DriverOnlineTime extends StatefulWidget {

  final int typeIndex;

  const DriverOnlineTime({Key key, this.typeIndex=0}) : super(key: key);

  @override
  _DriverOnlineTimeState createState() => _DriverOnlineTimeState();
}

class _DriverOnlineTimeState extends State<DriverOnlineTime> {
  List titles = ['本月在线','上月在线','全部'];
  int mSelected = 0;

  PageController _pageController = new PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pageController?.jumpToPage(widget.typeIndex);
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowWhiteAppBar(
        centerTitle: '在线时长',
      ),
      body: AppStackWidget(
          isUp: true,
          height: 70.0,
          topWidget: Container(
            height: 70.0,
            color: AppColors.whiteColor,
            margin: EdgeInsets.only(top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                createHeaderItem(0),
                createHeaderItem(1),
                createHeaderItem(2),
              ],
            ),
          ),
          downWidget: Container(
            child: PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index){
                debugPrint("当前索引：" + index.toString());
                mSelected = index;
                if (mounted) {
                  setState(() {});
                }
              },
              itemBuilder: (BuildContext context,int index){
                return OnlineSubList(typeIndex: index);
              },

            ),
          )
      ),
    );
  }

  createHeaderItem(int index){

    BorderRadius radius = BorderRadius.all(Radius.circular(0.0));
    Border border = Border.all(color: AppColors.mainColor,width: 1);
    switch(index){
      case 0:{
        radius = BorderRadius.only(topLeft: Radius.circular(40.0),bottomLeft:Radius.circular(40.0));
        border = Border.all(color: AppColors.mainColor,width: 1);
      }break;
      case 2:{
        radius = BorderRadius.only(topRight: Radius.circular(40.0),bottomRight:Radius.circular(40.0));
        border = Border.all(color: AppColors.mainColor,width: 1);
      }break;
      default:{}break;
    }
    return InkWell(
      onTap: (){
        setState(() {
          mSelected=index;
          _pageController?.jumpToPage(mSelected);
        });
      },
      child: Container(
        width: 100.0,
        height: 40.0,
        decoration: BoxDecoration(
            borderRadius: radius,
            border: border,
            color: mSelected==index?AppColors.mainColor:AppColors.whiteColor
        ),
        child: AppText(text: titles[index],color: mSelected==index?AppColors.whiteColor:AppColors.mainColor,),
      ),
    );
  }
}

class OnlineSubList extends StatefulWidget {

  final int typeIndex;

  const OnlineSubList({Key key,@required this.typeIndex}) : super(key: key);

  @override
  _OnlineSubListState createState() => _OnlineSubListState();
}

class _OnlineSubListState extends State<OnlineSubList> {
  EasyRefreshController _controller;
  List _list = [];
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  int _maxPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    _controller = EasyRefreshController();
    _onRefresh();
  }

  //读取缓存
  readData(){
    AppClass.readData(Api.centerOnlineTimeUrl+widget.typeIndex.toString()).then((value){
      if(value!=null){
        setState(() {
          _list = value;
        });
      }
    });
  }

  Future _onRefresh() async {
    _page = 1;
    getData();
  }

  getData(){
    var data = {
      'p':_page,
      'pageNum':15,
      'type':widget.typeIndex==2?1:widget.typeIndex+2
    };
    DioUtils.instance.post(Api.centerOnlineTimeUrl,data: data, onFailure: (code,msg){
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    },onSucceed: (response){
      if(response is Map){
        List list = response['list'];
        _maxPage = response['countPage'];
        showDataList(list);
      }else{
        if(mounted){
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  showDataList(List dataList) {
    if (_page == 1) {
      _list.clear();
      AppClass.saveData(dataList, Api.centerOnlineTimeUrl+widget.typeIndex.toString());
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

    return EasyRefresh(
        controller: _controller,
        onRefresh: ()async{
          _onRefresh();
        },
        onLoad: ()async{
          _loadMore();
        },
        child:_list.length == 0 ? Container(
            height: MediaQuery.of(context).size.height-50,child: StateLayout(type: _isLoading?StateType.loading:StateType.empty))
            : CustomScrollView(
          slivers: <Widget>[
//            SliverToBoxAdapter(
//              child: Container(
//                padding: EdgeInsets.only(bottom: 10),
//                color: AppColors.whiteColor,
//                height: 40.0,
//                child: AppText(text: '合计: 04天22小时21分',color: AppColors.orangeColor,),
//              ),
//            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                  return createItem(_list[index]);
                },childCount: _list.length)
            )
          ],
        )
    );

  }


  createItem(var data){

    List<Widget> list = [];
    list.add(AppCell(
      height: 40,
      title: '${AppClass.data(data, 'month')}-${AppClass.data(data, 'day')}',
      titleStyle: TextStyles.getBlackBoldText(15),
      content: '合计在线: ${AppClass.data(data, 'times')}',
      contentStyle: TextStyle(color: AppColors.mainColor,fontSize: 14),
    ));
    list.add(AppCell(
      height: 25,
      title: '${AppClass.data(data, 'start_time')}~${AppClass.data(data, 'end_time')}',
      content: '在线: ${AppClass.data(data, 'times')}',
      contentStyle: TextStyle(fontSize: 14,color: AppColors.blackColor),
    ));

//    for(int i = 0; i<3; i++){
//      list.add(AppCell(
//        height: 25,
//      title: '08:08:00~11:00:00',
//      content: '在线: 2小时52分',
//        contentStyle: TextStyle(fontSize: 14,color: AppColors.blackColor),
//      ));
//    }

    return Container(
      color: AppColors.whiteColor,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        children: list,
      ),
    );
  }


}

