
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../../public_header.dart';
import 'AmapLocationPicker.dart';
import 'PoiInfo.dart';



class AmapLocationAndSelectLocationPage extends StatefulWidget {
  @override
  _AmapLocationAndSelectLocationPageState createState() =>
      _AmapLocationAndSelectLocationPageState();
}

class _AmapLocationAndSelectLocationPageState
    extends State<AmapLocationAndSelectLocationPage> {

  var local;

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AmapLocationPicker(
        requestPermission: () {
          return Permission.location.request().then((it) => it.isGranted);
        },
        poiItemBuilder: (poi, selected) {
          return Container(
            height: 70,
            decoration: BoxDecoration(
              color: selected?AppColors.lightBlueColor:AppColors.whiteColor
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(width: 40,alignment: Alignment.center,
                      child: LoadAssetImage('定位',width: 15,fit: BoxFit.fitWidth,radius: 0.0,),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(child: Text(poi.title,maxLines: 2,style:TextStyles.getBlackBoldText(15),overflow: TextOverflow.ellipsis,)),
                            Expanded(child: Text(poi.address,maxLines: 2,style:TextStyle(fontSize: 14,color: AppColors.black54Color),overflow: TextOverflow.ellipsis,))
                          ],
                        ),
                      ),
                    )
                  ],
                )),
                Positioned(left: 0,right: 0,bottom: 0,child: SizedBox(
                  height: 1, width: double.infinity,
                  child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.bgColor)),
                ))
              ],
            ),
          );
        },
        onItemSelected: (PoiInfo poiInfo,isSure) {
          debugPrint('当前点击的位置${poiInfo.toString()}');
          local = {
            'address': poiInfo.poi.address,
            'title': poiInfo.poi.title,
            'city': poiInfo.poi.cityName,
            'district': poiInfo.poi.adName,
            'lon': poiInfo.poi.latLng.longitude,
            'lat': poiInfo.poi.latLng.latitude,
          };
          if(local!=null){
            AppPush.goBackWithParams(context, local);
          }
        },
      ),
    );
  }
}
