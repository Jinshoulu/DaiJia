
import 'package:demo/app_pages/order/OrderList.dart';
import 'package:demo/z_tools/app_widget/app_stack_widget.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

class OrderDone extends StatefulWidget {
  @override
  _OrderDoneState createState() => _OrderDoneState();
}

class _OrderDoneState extends State<OrderDone> with SingleTickerProviderStateMixin{



  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = new TabController(length: 4, vsync: this);
    _pageController = new PageController();

  }

  @override
  Widget build(BuildContext context) {

    return AppStackWidget(
        isUp: true,
        height: 60.0,
        topWidget: Container(
          margin: EdgeInsets.only(top: 10.0),
          color: AppColors.whiteColor,
          height: 50.0,
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.mainColor,
            labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            indicatorWeight: 2.0,
            labelPadding: EdgeInsets.symmetric(horizontal: 0),
            unselectedLabelColor: AppColors.blackColor,
            unselectedLabelStyle: TextStyle(fontSize: 13),
            onTap: (index) {
                _pageController?.jumpToPage(index);
            },
            tabs: <Widget>[
              Tab(text: '全部',),
              Tab(text: '优推单',),
              Tab(text: '系统单',),
              Tab(text: '报单',),
            ],
          ) ,
        ),
        downWidget: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index){
            debugPrint("当前索引：" + index.toString());
            if (mounted) {
              setState(() {});
            }
          },
          children: <Widget>[
            new OrderList(typeIndex: 0),
            new OrderList(typeIndex: 1),
            new OrderList(typeIndex: 2),
            new OrderList(typeIndex: 3),
          ],
        )
    );
  }
}
