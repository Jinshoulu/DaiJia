
import 'package:demo/app_pages/mine/tools/AddFamilyItem.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_set_cell.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/dialog/empty_bottom_sheet.dart';
import 'package:easy_contact_picker/easy_contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MineFamily extends StatefulWidget {
  @override
  _MineFamilyState createState() => _MineFamilyState();
}

class _MineFamilyState extends State<MineFamily> {

  EasyRefreshController _controller;
  List _list = ['','','','',];
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  int _maxPage = 1;

  final EasyContactPicker _contactPicker = new EasyContactPicker();

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
      appBar: ShowWhiteAppBar(
        centerTitle: '亲情号码列表',
        rightWidget: AppButton(
            title: '平安到家',
            textStyle: TextStyle(fontSize: 14,color: AppColors.mainColor),
            onPress: (){

            }
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,right: 0,top: 0,
              child: Container(
                color: AppColors.bgColor,
                height: 60.0,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: AppSetCell(
                    height: 40.0,
                    title: '导入通讯录',
                    titleColor: AppColors.mainColor,
                    showLine: false,
                    leftWidget: Container(
                      width: 20.0,
                      alignment: Alignment.center,
                      child: LoadAssetImage('我的-通讯录',width: 15,fit: BoxFit.fitWidth,radius: 0.0,),
                    ),
                    onPress: (){
                      showAddContactsTips();
                    }
                ),
              )
          ),
          Positioned(
              left: 0,right: 0,top: 60,bottom: 100.0,
              child: EasyRefresh(
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
                        return InkWell(
                          onLongPress: (){
                            AppShowBottomDialog.showNormalDialog(context,'取消','确定', '温馨提示', '确定删除当前亲情号', (){

                            });
                          },
                          child: ContainerAddLineWidget(
                              child: AppCell(
                                  title: '17756568994',
                                  content: '哥们儿'
                              )
                          ),
                        );
                      }
                  )
              )
          ),
          Positioned(
              left: 0,right: 0,bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                height: 80.0,
                alignment: Alignment.center,
                child: SizedBox(
                  height: 45.0,
                  child: AppButton(
                      radius: 45.0,
                      title:'添加',
                      image:'添加亲情号',
                      textStyle: TextStyles.whiteAnd14,
                      imageColor: AppColors.whiteColor,
                      buttonType: ButtonType.leftImage,
                      imageSize: 12,
                      bgColor: AppColors.mainColor,
                      onPress:(){
                        addFamily();
                      }
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  ///导入通讯录确认提示
  showAddContactsTips(){
    AppShowBottomDialog.showNormalDialog(
        this.context, 
        '取消', '确认', '协议签名确认', 
        '导入亲情号码后,亲情号码来电,不再自动开单,确定导入?', (){
          submitContacts();
    });
  }

  submitContacts(){
    Permission.contacts.request().then((value){
      if(value.isGranted){
        _getContactDataList();
      }else{
        Toast.show('通讯录权限被拒绝');
      }
    });
  }

  ///获取联系人列表 并进行提交
  _getContactDataList() async {
    ///全部联系人
    List<Contact> contacts = await _contactPicker.selectContacts();
    List <Map> dataSource = new List();
    contacts.forEach((element) {
      Map mm = new Map();
      mm['name'] = element.fullName;
      ///去除空格
      String phone = element.phoneNumber.replaceAll(' ', '');
      ///去除 '-'
      phone = phone.replaceAll('-', '');
      mm['phone'] = phone;
      dataSource.add(mm);
    });
    print(contacts);
  }


  ///添加亲情号
  addFamily(){
    showModalBottomSheet(
        context: this.context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return EmptyBottomSheet(
              edgeInsets: EdgeInsets.only(bottom: 30.0),
              topWidget: Container(
                  height: 60.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          left: 20,right: 20,
                          child: TextContainer(
                            alignment: Alignment.center,
                            slideColor: AppColors.black54Color,
                            title: '添加亲情号码',
                            height: 60,
                            style: TextStyle(fontSize: 18,color: AppColors.blackColor))),
                      Positioned(
                          left: 0,right: 0,bottom: 0,
                          child: Container(color: AppColors.black54Color,height: 1,),
                      )
                    ],
                  )
              ),
              centerWidget: AddFamilyItem(),
              downWidget: SizedBox()
          );
        }
    );
  }
}
