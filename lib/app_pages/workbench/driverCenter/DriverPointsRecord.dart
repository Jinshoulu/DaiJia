
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

class DriverPointsRecord extends StatefulWidget {
  @override
  _DriverPointsRecordState createState() => _DriverPointsRecordState();
}

class _DriverPointsRecordState extends State<DriverPointsRecord> {

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
        centerTitle: '代驾分记录',
      ),
      body: EasyRefresh.custom(
          controller: _controller,
          onRefresh: ()async{
            _onRefresh();
          },
          onLoad: ()async{
            _loadMore();
          },
          slivers: <Widget> [
            SliverToBoxAdapter(
              child: Container(
                height: 180.0,
                color: AppColors.whiteColor,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(20.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    LoadAssetImage('代驾分记录卡片'),
                    Container(
                      padding: EdgeInsets.only(left: 16,right: 16,bottom: 20),
                      child: Column(
                        children: <Widget>[
                          AppCell(title: '周期截止日期',titleStyle: TextStyles.whiteAnd14, content: '2020.12.12',contentStyle: TextStyles.whiteAnd14,),
                          Expanded(child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextContainer(
                                        alignment: Alignment.center,
                                        title: '09', height: 40, style: TextStyles.getWhiteBoldText(30)),
                                    TextContainer(
                                        alignment: Alignment.center,
                                        title: '剩余代驾分', height: 30, style: TextStyles.whiteAnd14),

                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextContainer(
                                        alignment: Alignment.center,
                                        title: '03', height: 40, style: TextStyles.getWhiteBoldText(30)),
                                    TextContainer(
                                        alignment: Alignment.center,
                                        title: '已扣费', height: 30, style: TextStyles.whiteAnd14),

                                  ],
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 70.0,
                color: AppColors.whiteColor,
                padding: EdgeInsets.only(left: 20,right: 20, bottom: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: AppButton(radius: 8.0,bgColor: AppColors.lightOrangeColor,title: '代驾分基本规则',image: '代驾分记录规则',imageSize: 30.0,buttonType: ButtonType.leftImage, onPress: (){
                          AppShowBottomDialog.showDelegateSheetDialog(context, '代驾分基本规则', '代驾分基本规则', (){

                          });
                        })
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                        child: AppButton(radius: 8.0,bgColor: AppColors.lightBlueColor,title: '代驾分触发标准',image: '代驾分记录处罚标准',imageSize: 30.0,buttonType: ButtonType.leftImage, onPress: (){
                          AppShowBottomDialog.showDelegateSheetDialog(context, '代驾分记录处罚标准', '代驾分记录处罚标准', (){

                          });
                        })
                    ),
                  ],
                ),
              ),
            ),
            _list.isEmpty?
            Container(
                height: MediaQuery.of(context).size.height-50,child: StateLayout(type: _isLoading?StateType.loading:_stateType)):
                SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                        return Container(
                          color: AppColors.whiteColor,
                          margin: EdgeInsets.only(top: 10.0),
                          padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 16),
                          child: Column(
                            children: <Widget>[
                              TextContainer(
                                  title: '2020-12-12',
                                  height: 30,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainColor
                                  )
                              ),
                              AppCell(height: 30,edgeInsets: EdgeInsets.all(0.0),title: '扣分', content: '2',contentStyle: TextStyle(fontSize: 14,color: AppColors.red),),
                              AppCell(height: 30,edgeInsets: EdgeInsets.all(0.0),title: '备注', content: '客户举报,客户争吵',contentStyle: TextStyles.blackAnd14,),
                            ],
                          ),
                      );
                    },childCount: _list.length)
                )
          ]
      ),
    );
  }
}
