
import 'package:demo/app_pages/workbench/driverCenter/DriverRecharge.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverWithdrawal.dart';
import 'package:demo/app_pages/workbench/driverCenter/DriverWithdrawalList.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../../../public_header.dart';

class DriverAccountDetail extends StatefulWidget {
  @override
  _DriverAccountDetailState createState() => _DriverAccountDetailState();
}

class _DriverAccountDetailState extends State<DriverAccountDetail> {

  EasyRefreshController _controller;
  List _list = [];
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  int _maxPage = 1;

  ///时间
  String time;
  var detailData;
  var baozhangType;
  List baozhangList = [];

  bool isFirst = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    DateTime dateTime = DateTime.now();
    time = dateTime.year.toString()+'-'+dateTime.month.toString()+'-'+dateTime.day.toString();
    _controller = EasyRefreshController();
    _onRefresh();

  }
  //读取缓存
  readData(){
    AppClass.readData(Api.mineBalanceUrl).then((value){
      if(value!=null){
        setState(() {
          detailData = value;
        });
      }
    });
    AppClass.readData(Api.mineDimoneyRecordUrl).then((value){
      if(value!=null){
        setState(() {
          _list = value;
        });
      }
    });
  }

  Future _onRefresh() async {
    _page = 1;
    getDetailInfoData();
  }
  //获取账户余额、保障金、邀请人数、变化类型
  getDetailInfoData(){
    DioUtils.instance.post(Api.mineBalanceUrl, onFailure: (code,msg){
      reloadState();
    },onSucceed: (response){
      if(response is Map){
        detailData = response;
        AppClass.saveData(detailData, Api.mineBalanceUrl);
        if(detailData['imoney_type']!=null){
          if(detailData['imoney_type'] is List){
            baozhangList = detailData['imoney_type'];
            if(baozhangList.isNotEmpty){
              baozhangType = baozhangList.first;
              getBaozhangData(baozhangType);
            }else{
              debugPrint('返回的数据是空的');
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
        Toast.show('返回的数据类型有问题，请联系后台');
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

  ///获取保障金明细
  getBaozhangData(Map data){

    var parameters = {
      'p':_page,
      'pageNum':15,
      'type':AppClass.data(data, 'type'),
      'date':time
    };
    DioUtils.instance.post(Api.mineDimoneyRecordUrl,data: parameters, onFailure: (code,msg){
     reloadState();
    },onSucceed: (response){
      if(response is Map){
        List list = response['list'];
        _maxPage = response['countPage'];
        showDataList(list);
      }else{
        reloadState();
      }
    });
  }

  showDataList(List dataList) {
    if (_page == 1) {
      _list.clear();
      AppClass.saveData(dataList, Api.mineDimoneyRecordUrl);
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
    getBaozhangData(baozhangType);
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
      body: AppStackWidget(
          topWidget: EasyRefresh(
            controller: _controller,
            onLoad: ()async{
              _loadMore();
            },
            onRefresh: ()async{
              _onRefresh();
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: AppColors.transparentColor,
                  leading: IconButton(
                    onPressed: () {
                      AppPush.goBack(context);
                    },
                    tooltip: 'Back',
                    padding: const EdgeInsets.all(12.0),
                    icon: LoadAssetImage('back_black',width: 25,height: 25,radius: 0.0,color: AppColors.whiteColor,),
                  ) ,
                  title: Text('账户明细'),
                  centerTitle: true,
                  floating: false,
                  pinned: true,
                  snap: false,
                  expandedHeight: 250.0,
                  flexibleSpace: new FlexibleSpaceBar(
                    background: Stack(
                      children: <Widget>[
                        Positioned(left: 0,top: 0,right: 0,bottom: 70.0,child: LoadAssetImage('账户明细背景',radius: 0.0,)),
                        Positioned(left: 16,right: 16,top: 100,bottom: 20,child: Card(
                          elevation: 4.0,
                          shadowColor: AppColors.lightBlueColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            TextContainer(
                                                alignment: Alignment.center,
                                                title: '账户余额(元)',
                                                height: 30.0,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.black87Color)),
                                            SizedBox(height: 5,),
                                            TextContainer(
                                                alignment: Alignment.center,
                                                title: AppClass.data(detailData, 'imoney'),
                                                height: 30.0,
                                                style: TextStyles.getBlackBoldText(18)),

                                          ],
                                        ),
                                      )),
                                      Expanded(child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 30.0,
                                              child: AppButton(
                                                  title: '可提现',
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.black87Color),
                                                  buttonType: ButtonType.rightImage,
                                                  imageSize: 15,
                                                  imageColor: AppColors.black87Color,
                                                  image: '问题-疑问',
                                                  onPress: null
                                              ),
                                            ),
                                            TextContainer(
                                                alignment: Alignment.center,
                                                title: AppClass.data(detailData, 'money'),
                                                height: 30.0,
                                                style: TextStyles.getBlackBoldText(18)),

                                          ],
                                        ),
                                      )),
                                      Expanded(child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            TextContainer(
                                                alignment: Alignment.center,
                                                title: '邀请人数',
                                                height: 30.0,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.black87Color)),
                                            SizedBox(height: 5,),
                                            TextContainer(
                                                alignment: Alignment.center,
                                                title: AppClass.data(detailData, 'count_user'),
                                                height: 30.0,
                                                style: TextStyles.getBlackBoldText(18)),

                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                )),
                                Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      border: Border(top: BorderSide(color: AppColors.bgColor,width: 1))
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(child: AppButton(title: '订单保障费',image: '账户明细-订单保障费',rightImage: 'ic_arrow_right',imageSize: 20,rightImageSize: 15,rightImageColor: AppColors.blackColor,buttonType: ButtonType.leftImageAndRightImage, onPress: (){
                                          AppShowBottomDialog.showBottomListSheet(
                                              context,
                                              '类型选择',
                                              baozhangList,
                                              (value){
                                                baozhangType = value;
                                                setState(() {
                                                  _isLoading=true;
                                                  _list.clear();
                                                });
                                                _onRefresh();
                                              });
                                      })),
                                      SizedBox(
                                        height: double.infinity,
                                        width: 1,
                                        child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.bgColor)),
                                      ),
                                      Expanded(child: AppButton(title: '选择月份',image: '账户明细-选择月份',rightImage: 'ic_arrow_right',imageSize: 20,rightImageSize: 15,rightImageColor: AppColors.blackColor,buttonType: ButtonType.leftImageAndRightImage, onPress: (){
                                        showPickerDate(context);
                                      })),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                _list.isEmpty?
                SliverToBoxAdapter(
                  child: Container(
                      height: MediaQuery.of(context).size.width,child: StateLayout(type: _isLoading?StateType.loading:StateType.empty)
                  ),
                ):
                SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                      var data = _list[index];
                      double value = double.parse(AppClass.data(data, 'num'));
                      return ContainerAddLineWidget(
                          height: 65,
                          child: Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10,right: 16,left: 16),
                            child: Column(
                              children: <Widget>[
                                Expanded(child: Row(
                                  children: <Widget>[
                                    Expanded(child: AppText(alignment: Alignment.centerLeft,text: 'msg')),
                                    Container(width: 100.0,alignment: Alignment.centerRight,child: Text(value.toString(),style: TextStyle(fontSize: 14,color: value>0?AppColors.greenColor:AppColors.red, fontWeight: FontWeight.bold),),)
                                  ],
                                )),
                                Expanded(child: Row(
                                  children: <Widget>[
                                    Container(width: 150.0,alignment: Alignment.centerLeft,child: Text(AppClass.data(data, 'create_time'),style: TextStyle(fontSize: 12,color: AppColors.black54Color),),),
                                    Expanded(child: AppText(alignment: Alignment.centerRight,text: '余额: ${AppClass.data(data, 'money')}',fonSize: 12,)),
                                  ],
                                )),
                              ],
                            ),
                          )
                      );
                    },childCount: _list.length)
                )
              ],
            ),
          ),
          height: 60.0,
          downWidget: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.black33Color,width: 1))
            ),
            padding: EdgeInsets.only(right: 16),
            height: 60.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(child: SizedBox()),
                SizedBox(
                  height: 40.0,
                  width: 120.0,
                  child: AppButton(title: '充值',radius: 40.0, bgColor: AppColors.orangeColor,textStyle: TextStyles.whiteAnd14, onPress: (){
                      AppPush.pushDefault(context, DriverRecharge());
                  }),
                ),
//                SizedBox(width: 10.0,),
//                SizedBox(
//                  height: 40.0,
//                  width: 120.0,
//                  child: AppButton(title: '提现',radius: 40.0, bgColor: AppColors.mainColor,textStyle: TextStyles.whiteAnd14, onPress: (){
//
//                    AppPush.pushDefault(context, DriverWithdrawalList());
//
//                  }),
//                ),
              ],
            ),
          )
      ),
    );
  }

  showPickerDate(BuildContext context) {
    Picker(
        adapter: DateTimePickerAdapter(
            maxValue: DateTime.now(),
            type: PickerDateTimeType.kYM,
            months: ['1','2','3','4','5','6','7','8','9','10','11','12']
        ),
        height: 200,
        title: Text("选择时间"),
        selectedTextStyle: TextStyle(color: AppColors.orangeColor),
        onConfirm: (Picker picker, List value) {
          DateTime dateTime =  (picker.adapter as DateTimePickerAdapter).value;
          setState(() {
            String currentTime = dateTime.year.toString()+'-'+dateTime.month.toString()+'-'+'01';
            setState(() {
              time = currentTime;
              setState(() {
                _isLoading=true;
                _list.clear();
              });
              getBaozhangData(baozhangType);
            });
          });
        }
    ).showModal(context);
  }

}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
