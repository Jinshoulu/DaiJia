
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:flutter/material.dart';

class DriverScoreDetail extends StatefulWidget {

  final int typeIndex;

  const DriverScoreDetail({Key key, this.typeIndex = 0}) : super(key: key);

  @override
  _DriverScoreDetailState createState() => _DriverScoreDetailState();
}

class _DriverScoreDetailState extends State<DriverScoreDetail> {

  List titles = ['本月积分','上月积分','全部'];
  int mSelected = 0;

  PageController _pageController = new PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
        centerTitle: '积分明细',
      ),
      body: AppStackWidget(
          isUp: true,
          height: 90.0,
          topWidget: Container(
            height: 80.0,
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
            margin: EdgeInsets.only(top: 10.0),
            color: AppColors.whiteColor,
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (index){
                debugPrint("当前索引：" + index.toString());
                mSelected = index;
                if (mounted) {
                  setState(() {});
                }
              },
              children: <Widget>[
                ScoreSubList(typeIndex: 0,),
                ScoreSubList(typeIndex: 1,),
                ScoreSubList(typeIndex: 2,),
              ],
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

class ScoreSubList extends StatefulWidget {

  final int typeIndex;

  const ScoreSubList({Key key, this.typeIndex}) : super(key: key);

  @override
  _ScoreSubListState createState() => _ScoreSubListState();
}

class _ScoreSubListState extends State<ScoreSubList> {

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
    
    return EasyRefresh(
        controller: _controller,
        onRefresh: ()async{
          _onRefresh();
        },
        onLoad: ()async{
          _loadMore();
        },
        child:_list.length == 0 ? Container(
            height: MediaQuery.of(context).size.height-50,child: StateLayout(type: _isLoading?StateType.loading:_stateType))
            : CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(height: 10.0,),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                color: AppColors.whiteColor,
                height: 40.0,
                child: AppText(alignment: Alignment.centerRight, text: '合计: 1222分',color: AppColors.orangeColor,),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 40.0,
                color: AppColors.lightBlueColor,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2,child: AppText(text: '订单时间/被邀请人',color: AppColors.mainColor,fonSize: 13,)),
                    Expanded(flex: 1,child: AppText(text: '类型',color: AppColors.mainColor,fonSize: 13,)),
                    Expanded(flex: 1,child: AppText(text: '积分',color: AppColors.mainColor,fonSize: 13,)),
                    Expanded(flex: 1,child: AppText(text: '返利',color: AppColors.mainColor,fonSize: 13,)),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                  return ContainerAddLineWidget(
                      edgeInsets: EdgeInsets.only(left: 0,right: 0),
                      child: Container(
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            createContainer(2, Text('2020.12.12',style: TextStyle(fontSize: 12,color: AppColors.blackColor),)),
                            createContainer(1, Text('标兵代驾',style: TextStyle(fontSize: 12,color: AppColors.red),)),
                            createContainer(1, Text('99999',style: TextStyle(fontSize: 12,color: AppColors.blackColor),)),
                            createContainer(1, Text('99999',style: TextStyle(fontSize: 12,color: AppColors.blackColor),)),
                          ],
                        ),
                      )
                  );
                },childCount: _list.length)
            )
          ],
        )
    );

  }

  createContainer(int size,Widget text){
    return Expanded(
        flex: size,
        child: Container(
          alignment: Alignment.center,
          child: text,
        )
    );
  }


}

