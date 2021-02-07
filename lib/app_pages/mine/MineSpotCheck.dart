
import 'package:demo/app_pages/mine/bean/SpotCheckBean.dart';
import 'package:demo/app_pages/mine/tools/SpotCheckItem.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_bus_event.dart';
import 'package:demo/z_tools/app_widget/app_add_images_widget.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/image/AppSubmitImage.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/material.dart';

class MineSpotCheck extends StatefulWidget {
  @override
  _MineSpotCheckState createState() => _MineSpotCheckState();
}

class _MineSpotCheckState extends State<MineSpotCheck> {

  EasyRefreshController _controller;
  List _list = [];
  List subImages = [];
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
    AppClass.readData(Api.mineSpotCheckRecordUrl).then((value){
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
    };
    DioUtils.instance.post(Api.mineSpotCheckRecordUrl,data: data, onFailure: (code,msg){
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
      AppClass.saveData(dataList, Api.mineSpotCheckRecordUrl);
    }
    _list.addAll(dataList);
    dataList.forEach((element) {
      List<ImageBean> images = [];
      subImages.add(images);
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ShowWhiteAppBar(
        centerTitle: '抽检列表',
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
              height: MediaQuery.of(context).size.height-50,child: StateLayout(type: _isLoading?StateType.loading:StateType.empty))
              : ListView.builder(
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                /// 不需要加载更多则不需要添加FootView
                return createContainerItem(index);
              }
          )
      ),
    );
  }


  createContainerItem(int index){

    SpotCheckBean bean = SpotCheckBean.fromJson(_list[index],);

    return Container(
      color: AppColors.whiteColor,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          ContainerAddLineWidget(
              child: AppCell(title: '抽检时间: ${AppClass.data(_list[index], 'create_time')}', content: '上传时间: ${AppClass.data(_list[index], 'up_time')}')
          ),
          SizedBox(height: 20.0,),
          bean.fileurls==null||bean.fileurls.length==0
              ?createUploadRecord(index)
              :GridView.builder(
            padding: EdgeInsets.only(left: 16,right: 16),
              shrinkWrap: true,
              itemCount: bean?.fileurls?.length,
              physics: new NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                  crossAxisCount: 4,
                  //纵轴间距
                  mainAxisSpacing: 20.0,
                  //横轴间距
                  crossAxisSpacing: 10.0,
                  //子组件宽高长度比例
                  childAspectRatio: 1.0),
              itemBuilder: (BuildContext context, int index){
                return Container(
                  child: LoadImage(bean?.fileurls[index],radius: 0.0,),
                );
              }
          ),
          SizedBox(height: 20.0,),
        ],
      ),
    );
  }

  createUploadRecord(int index){
    return SizedBox(
      width: double.infinity,
      height: 100.0,
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: AppAddImageWidget(
            maxCount: 2,
            showImages: subImages[index],
            imageFiles: (List<ImageBean> files){
              subImages.removeAt(index);
              subImages.insert(index, files);
              setState(() {

              });
            },
          )),
          Positioned(
              right: 0, top: 0,bottom: 0,
              child: Container(
                width: 100.0,
                alignment: Alignment.center,
                child: SizedBox(
                  width: 70.0,
                  height: 30.0,
                  child: AppButton(radius: 30.0,bgColor: AppColors.mainColor,title: '提交',textStyle: TextStyles.whiteAnd12, onPress:(){
                      submitData(subImages[index], AppClass.data(_list[index], 'id'));
                  }),
                ),
              )
          )
        ],
      ),
    );
  }

  createEditContainer(){

    return SpotCheckItem(
        submitResult: (){
          eventBus.fire(ReloadListPage());
        },
        bean: SpotCheckBean()
    );
  }

  submitData(List<ImageBean> images,id){
    List files = [];
    images.forEach((element) { 
      files.add(element.data.fileurls);
    });
    var data = {
      'id': id,
      'fileurls':files
    };
    DioUtils.instance.post(Api.mineSubmitSpotCheckRecordUrl,data: data,onSucceed: (response){
      setState(() {});
    },onFailure: (code,msg){

    });
  }
}
