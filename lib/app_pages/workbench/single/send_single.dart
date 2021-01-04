

import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_label_cell.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/dialog/empty_bottom_sheet.dart';
import 'package:demo/z_tools/dialog/list_bottom_sheet.dart';
import 'package:demo/z_tools/dialog/operate_mode2_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class SendSingle extends StatefulWidget {
  @override
  _SendSingleState createState() => _SendSingleState();
}

class _SendSingleState extends State<SendSingle> {

  List images = [];

  double imageSize = 15.0;
  //注册人手机
  String phone;
  //目的地
  String address;
  //出发时间
  String time;
  //几位代驾
  String driverNumber;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = ['派单-电话','派单-位置','派单-时间','派单-代驾'];
    phone = '15138670677';
    address = '中州大道黄河路金成时代广场附近';
    time = '现在出发';
    driverNumber = '1位代驾';


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '我要派单',
        rightWidget: SizedBox(
          child: AppButton(title: '我派的单', textStyle: TextStyle(fontSize: 14,color: AppColors.mainColor), image: null, onPress: (){
            AppPush.push(context, HomeRouter.mineSingle);
          }),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          children: <Widget>[
            Container(
              height: 45.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Row(
                    children: <Widget>[
                      Container(
                        width: 45.0,
                        alignment: Alignment.center,
                        child: LoadAssetImage(images[0],fit: BoxFit.fitWidth,width: imageSize,radius: 0.0,),
                      ),
                      Expanded(
                          child: RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                        style: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.blackColor),
                                        text: phone??''
                                    ),
                                    TextSpan(
                                        style: TextStyle(fontSize: Dimens.font_sp14,color: AppColors.black54Color),
                                        text: '（默认注册人手机,可修改）'
                                    ),
                                  ]
                              )
                          )
                      )
                    ],
                  )),
                  Positioned(left: 16,right: 16,bottom: 0,child: SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.bgColor)),
                  ))
                ],
              ),
            ),
            AppLabelCell(
              edgeInsets: EdgeInsets.only(right: 10),
              image: images[1],
              imageSize: imageSize,
              title: address??'',
              showRightImage: true,
              onPress: (){
                 AppPush.pushResult(context, HomeRouter.selectMap, (result){
                   Map data  = result;
                   setState(() {
                     address = '${data['title']??''}${data['address']??''}';
                   });
                   print('收到的 地址信息 result = $address');
                 });
              },
            ),
            AppLabelCell(
              edgeInsets: EdgeInsets.only(right: 10),
              image: images[2],
              imageSize: imageSize,
              title: time??'',
              showRightImage: true,
              onPress: (){
                showPickerDate(context);
              },
            ),
            AppLabelCell(
              edgeInsets: EdgeInsets.only(right: 10),
              image: images[3],
              imageSize: imageSize,
              title: driverNumber??'',
              showRightImage: true,
              onPress: (){
                showModalBottomSheet(
                  context: context,
                  /// 使用true则高度不受16分之9的最高限制
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return EmptyBottomSheet(
                      edgeInsets: EdgeInsets.only(left: 0,right: 0, bottom: 16),
                       topWidget: TextContainer(
                           showBottomSlide: true,
                           slideColor: AppColors.black33Color,
                           alignment: Alignment.center,
                           title: '需要几位代驾',
                           height: 60,
                           style: TextStyle(
                               fontSize: Dimens.font_sp18,
                               fontWeight: FontWeight.bold,
                               color: AppColors.blackColor
                           )
                       ),
                      centerWidget: Container(
                        height: 250,
                        child: ListView(
                          children: createListView(),
                        ),
                      ),
                      downWidget: SizedBox(),
                    );
                  },
                );
              },
            )

          ],
        ),
      ),
    );
  }
  createListView(){
    List titles = ['1位代驾','2位代驾','3位代驾','4位代驾','5位代驾'];
    List<Widget> list = [];
    for(int i = 0; i<titles.length; i++){
      list.add(InkWell(
        onTap: (){
          Navigator.pop(context);
          setState(() {
            driverNumber = titles[i];
          });
        },
          child: TextContainer(
              alignment: Alignment.center,title: titles[i], height: 50,
              style: TextStyle(
                fontSize: 14,color: AppColors.blackColor
              )
          )
      ));
    }
    return list;
  }

  showPickerDate(BuildContext context) {
    Picker(
        adapter: DateTimePickerAdapter(
            minValue: DateTime.now(),
            type: PickerDateTimeType.kYMDHMS,
            months: ['1','2','3','4','5','6','7','8','9','10','11','12']
        ),
        title: Text("出发时间"),
        selectedTextStyle: TextStyle(color: AppColors.orangeColor),
        onConfirm: (Picker picker, List value) {
          DateTime dateTime =  (picker.adapter as DateTimePickerAdapter).value;
          setState(() {
            String currentTime = dateTime.year.toString()+'-'+dateTime.month.toString()+'-'+dateTime.day.toString()+'-'+dateTime.hour.toString()+'-'+dateTime.minute.toString();
            setState(() {
              time = '出发时间:  $currentTime';
            });
          });
        }
    ).showModal(context);
  }

}
