
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/app_widget/app_cell.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/material.dart';

class DriverOrderDetail extends StatefulWidget {

  final int typeIndex;

  const DriverOrderDetail({Key key, this.typeIndex = 0}) : super(key: key);


  @override
  _DriverOrderDetailState createState() => _DriverOrderDetailState();
}

class _DriverOrderDetailState extends State<DriverOrderDetail> {

  List titles = ['本月订单','上月订单','全部'];
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
        centerTitle: '订单明细',
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
          downWidget: PageView(
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
              new OrderSubList(typeIndex: 0,),
              new OrderSubList(typeIndex: 1,),
              new OrderSubList(typeIndex: 2,),
            ],
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


class OrderSubList extends StatefulWidget {

  final int typeIndex;

  const OrderSubList({Key key,@required this.typeIndex}) : super(key: key);


  @override
  _OrderSubListState createState() => _OrderSubListState();
}

class _OrderSubListState extends State<OrderSubList> {

  List dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AppRefreshWidget(
        itemBuilder: (BuildContext context, int index){
          return createItem();
        },
        requestData: {},
        requestUrl: Api.registerUrl,
        requestBackData: (List list){
          if(mounted){
           setState(() {
             dataList = list;
           });
          }
        }
    );
  }

  createItem(){
    return Container(
      padding: EdgeInsets.only(top: 10,bottom: 10),
      margin: EdgeInsets.only(top: 10),
      color: AppColors.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ContainerAddLineWidget(
            edgeInsets: EdgeInsets.all(0.0),
              child: AppCell(
                  title: '2132021321321321320135',
                  content: '收入12.5元',
                contentStyle: TextStyle(color: AppColors.mainColor,fontSize: 14),
              )
          ),
          SizedBox(height: 5,),
          Padding(
              padding: EdgeInsets.only(left: 16,right: 16),
            child: createListItem('订单-目的地', '出发地: 金成时代广场9号楼'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: createListItem('订单-目的地', '目的地: 绿博园'),
          ),
          Container(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: createListItem('订单-里程', '实际里程: 10.30km')),
                Expanded(child: createListItem('订单-用时', '21分20秒')),
              ],
            ),
          ),
          SizedBox(height: 5,),

        ],
      ),
    );
  }

  createListItem(String image,String title){
    return Container(
      height: 30.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: LoadAssetImage(image,width: 15,fit: BoxFit.fitWidth,radius: 0.0),
          ),
          SizedBox(width: 5,),
          SizedBox(child: Text(title,style: TextStyle(fontSize: 14),))
        ],
      ),
    );
  }
}
