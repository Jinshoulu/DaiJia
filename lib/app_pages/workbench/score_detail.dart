
import 'package:demo/public_header.dart';
import 'package:demo/z_tools/app_widget/app_button.dart';
import 'package:demo/z_tools/app_widget/container_add_line_widget.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ScoreDetail extends StatefulWidget {
  @override
  _ScoreDetailState createState() => _ScoreDetailState();
}

class _ScoreDetailState extends State<ScoreDetail> {
  
  List dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataList.add('value');
    dataList.add('value');
    dataList.add('value');
    dataList.add('value');
    dataList.add('value');
    dataList.add('value');
    dataList.add('value');


  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.mainColor,
            leading: IconButton(
              onPressed: () {
                AppPush.goBack(context);
              },
              tooltip: 'Back',
              padding: const EdgeInsets.all(12.0),
              icon: LoadAssetImage('back_black',width: 25,height: 25,radius: 0.0,color: AppColors.whiteColor,),
            ) ,
            title: Text('积分明细'),
            centerTitle: true,
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 250.0,
            flexibleSpace: new FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  Positioned.fill(child: LoadAssetImage('积分明细背景',format: 'jpg',radius: 0.0,)),
                  Positioned.fill(child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 100,child: AppButton(title: '积分余额',textStyle: TextStyles.whiteAnd14, image: '积分',imageSize: 15,buttonType: ButtonType.leftImage, onPress: (){})),
                        SizedBox(height: 2,),
                        TextContainer(alignment: Alignment.center,title: '2501', height: 50, style: TextStyles.getWhiteBoldText(40)),
                      ],
                    ),
                  )),
                  Positioned(left: 0,right: 0,bottom: 0,child: Container(
                    height: 45.0,
                    padding: EdgeInsets.only(left: 16,right: 10),
                    color: AppColors.whiteColor.withOpacity(0.2),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: InkWell(
                          onTap: (){
                            AppPush.push(context, HomeRouter.pushMoneyAndScore);
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('如何获取积分?',style: TextStyle(fontSize: 14,color: AppColors.whiteColor),),
                          ),
                        )),
                        Container(
                          width: 20.0,
                          child: Center(
                            child: LoadAssetImage('ic_arrow_right', height: 15.0, width: 15.0,radius: 0.0,color: AppColors.whiteColor,),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return createItem();
          },childCount: dataList.length))
        ],
      ),
    );
  }

  createItem(){
    return StickyHeader(
        header: Container(
          padding: EdgeInsets.only(left: 16,right: 16),
          height: 45.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10))),
              ),
              SizedBox(width: 10,),
              TextContainer(
                  title: '12月28日',
                  height: 45,
                  style: TextStyle(
                      fontSize: 15, color: AppColors.blackColor,fontWeight: FontWeight.bold))
            ],
          ),
        ),
        content: createSubItem(['', ''])
    );
  }

  createSubItem(List data){
    List<Widget> list = List.generate(data.length, (index) {
      return ContainerAddLineWidget(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('签到获得积分1积分', style: TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,),
                  ),
                ),
                Container(
                  child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: '余额  ',
                                style: TextStyle(fontSize: 12,color: AppColors.blackColor)
                            ),
                            TextSpan(
                                text: '90分',
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.red)
                            )
                          ]
                      )
                  ),
                )
              ],
            ),
          )
      );
    });
    return Column(
      children: list,
    );
  }
}
