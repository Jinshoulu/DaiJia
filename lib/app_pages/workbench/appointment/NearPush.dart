
import 'package:demo/app_pages/workbench/appointment/AppointmentItem.dart';
import 'package:demo/z_tools/net/http_api.dart';
import 'package:demo/z_tools/refresh/app_refresh_widget.dart';
import 'package:flutter/material.dart';

class NearPush extends StatefulWidget {
  @override
  _NearPushState createState() => _NearPushState();
}

class _NearPushState extends State<NearPush> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppRefreshWidget(
        itemBuilder: (BuildContext context, int index){
          return AppointmentItem(
            data: {},
          );
        },
        requestData: {},
        requestUrl: Api.baseApi,
        requestBackData: (List list){
          setState(() {
            dataList = list;
          });
        }
    );
  }
}
