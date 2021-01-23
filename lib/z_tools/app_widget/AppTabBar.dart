
import 'package:flutter/material.dart';

import '../../public_header.dart';

class AppTabBar extends StatefulWidget {

  final List<String> titles;
  final Function onTap;
  final TabController tabController;
  final double height;

  const AppTabBar({
    Key key,
    @required this.titles,
    @required this.onTap,
    this.tabController,
    this.height = 50.0
  }) : super(key: key);

  @override
  _AppTabBarState createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: widget.titles.length, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        height: widget.height-10.0,
        color: AppColors.whiteColor,
        child: TabBar(
            controller: widget.tabController??_tabController,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.mainColor,
            labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            indicatorWeight: 2.0,
            labelPadding: EdgeInsets.symmetric(horizontal: 0),
            unselectedLabelColor: AppColors.blackColor,
            unselectedLabelStyle: TextStyle(fontSize: 13),
            onTap: (int index){
              widget.onTap(index);
            },
            tabs: List.generate(widget.titles.length, (index){
              return Tab(
                text: widget.titles[index],
              );
            })
        ),
    );
  }
}
