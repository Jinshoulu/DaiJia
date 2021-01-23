import 'package:demo/app_pages/workbench/exchangeCenter/ChangeRecord.dart';
import 'package:demo/app_pages/workbench/exchangeCenter/UseRecord.dart';
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_size_box.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';

class ExchangeCenter extends StatefulWidget {
  @override
  _ExchangeCenterState createState() => _ExchangeCenterState();
}

class _ExchangeCenterState extends State<ExchangeCenter> {
  ///兑换一次
  bool changeOneTime = true;
  bool isOpen = true;
  int changeNumber = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: '优推兑换',
        rightWidget: AppButton(
            title: '优推说明',
            textStyle: TextStyles.mainAnd14,
            onPress: () {
              AppShowBottomDialog.showDelegateSheetDialog(
                  context, '优推说明', '优推说明文档', '确定', () {});
            }),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppSizeBox(),
            headerContainer(),
            AppSizeBox(),
            ContainerAddLineWidget(
                edgeInsets: EdgeInsets.only(left: 0, right: 0),
                disW: 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '使用优推', style: TextStyles.blackAnd14),
                            TextSpan(
                                text: '（计时类型下线，服务中不计时）',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: AppColors.black54Color))
                          ])),
                        ),
                      ),
                      Container(
                        width: 70.0,
                        child: AppButton(
                            image: isOpen ? '开关-开' : '开关-关',
                            imageSize: 40,
                            buttonType: ButtonType.onlyImage,
                            onPress: () {
                              setState(() {
                                isOpen = !isOpen;
                              });
                            }),
                      )
                    ],
                  ),
                )),
            ContainerAddLineWidget(
                edgeInsets: EdgeInsets.only(left: 0, right: 0),
                disW: 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '兑换数量:', style: TextStyles.blackAnd14),
                          ])),
                        ),
                      ),
                      Container(
                        width: 100.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(
                                color: AppColors.black54Color, width: 1)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 30.0,
                              child: AppButton(
                                  image: '数量-减',
                                  imageSize: 30,
                                  imageColor: AppColors.blackColor,
                                  buttonType: ButtonType.onlyImage,
                                  onPress: () {
                                    setState(() {
                                      if (changeNumber > 1) {
                                        changeNumber--;
                                      }
                                    });
                                  }),
                            ),
                            Expanded(
                                child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: AppColors.black54Color,
                                          width: 1),
                                      right: BorderSide(
                                          color: AppColors.black54Color,
                                          width: 1))),
                              child: Text(
                                '$changeNumber',
                                style: TextStyles.mainAnd14,
                              ),
                            )),
                            SizedBox(
                              width: 30.0,
                              child: AppButton(
                                  image: '数量-加',
                                  imageSize: 30,
                                  imageColor: AppColors.blackColor,
                                  buttonType: ButtonType.onlyImage,
                                  onPress: () {
                                    setState(() {
                                      changeNumber++;
                                    });
                                  }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            ContainerAddLineWidget(
                edgeInsets: EdgeInsets.only(left: 0, right: 0),
                disW: 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '优推持有数量:', style: TextStyles.blackAnd14),
                        ])),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(text: '2/5', style: TextStyles.blackAnd14),
                          ])),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              height: 60,
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: AppButton(
                    title: '确认兑换',
                    radius: 40.0,
                    bgColor: AppColors.mainColor,
                    textStyle: TextStyles.whiteAnd14,
                    onPress: () {}),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              height: 40.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: AppButton(
                        title: '兑换记录',
                        textStyle: TextStyles.mainAnd14,
                        onPress: () {
                          showChangeRecord();
                        }),
                  ),
                  Expanded(child: SizedBox()),
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: AppButton(
                        title: '使用记录',
                        textStyle: TextStyles.mainAnd14,
                        onPress: () {
                          showUseRecord();
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20 + MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  //**************** 弹窗
  showChangeRecord() {
    AppShowBottomDialog.showEmptyCenterSheetDialog(
        this.context,
        '兑换记录',
        SizedBox(
          width: 60.0,
          child: AppButton(title: '清除',textStyle: TextStyle(fontSize: 14,color: AppColors.orangeColor), onPress: (){

          }),
        ),
        Container(
          height: 350.0,
          child: ChangeRecord(),
        ),
        '',
        () {});
  }

  showUseRecord() {
    AppShowBottomDialog.showEmptyCenterSheetDialog(
        this.context,
        '使用记录',
        SizedBox(
          width: 60.0,
          child: AppButton(title: '清除',textStyle: TextStyle(fontSize: 14,color: AppColors.orangeColor), onPress: (){

          }),
        ),
        Container(
          height: 350.0,
          child: UseRecord(),
        ),
        '',
            () {});
  }

  //***************** header
  headerContainer() {
    return Container(
      height: 250.0,
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextContainer(
                  alignment: Alignment.center,
                  title: '---- 可用积分 ----',
                  height: 30.0,
                  style: TextStyle(color: AppColors.black87Color)),
              TextContainer(
                  alignment: Alignment.center,
                  title: '2500',
                  height: 50.0,
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              SizedBox(
                width: double.infinity,
                height: 30.0,
                child: AppButton(
                    title: '如何获得积分?',
                    textStyle:
                        TextStyle(fontSize: 14, color: AppColors.orangeColor),
                    onPress: () {
                      AppShowBottomDialog.showDelegateSheetDialog(
                          context, '如何获取积分', '这是获取积分的方法', '确定', () {});
                    }),
              )
            ],
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  subContainer('1次', '300积分', changeOneTime, () {
                    setState(() {
                      changeOneTime = true;
                    });
                  }),
                  SizedBox(
                    width: 50.0,
                  ),
                  subContainer('2次', '600积分', !changeOneTime, () {
                    setState(() {
                      changeOneTime = false;
                    });
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  subContainer(String title, String content, bool isSelect, Function onPress) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        width: 120.0,
        height: 60.0,
        decoration: BoxDecoration(
            color: isSelect ? AppColors.mainColor : AppColors.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(color: AppColors.mainColor, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextContainer(
                alignment: Alignment.center,
                title: title,
                height: 20,
                style: isSelect ? TextStyles.whiteAnd14 : TextStyles.mainAnd14),
            TextContainer(
                alignment: Alignment.center,
                title: content,
                height: 20,
                style: isSelect ? TextStyles.whiteAnd14 : TextStyles.mainAnd14),
          ],
        ),
      ),
    );
  }
}
