
import 'package:demo/z_tools/app_widget/AppText.dart';
import 'package:demo/z_tools/res/utils.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';

class CustomerServiceDialog extends StatefulWidget {

  final String content;
  final String title;
  final String cancelText;
  final String sureText;
  final bool isHiddenCancel;
  final Function surePress;
  final double width;
  final double imageSize;
  final List phones;

  const CustomerServiceDialog({
    Key key,
    @required this.surePress,
    @required this.content,
    @required this.phones,
    this.title = '人工客服电话',
    this.cancelText = '取消',
    this.sureText = '我知道了',
    this.isHiddenCancel = false,
    this.width = 280.0,
    this.imageSize = 80.0


  }) : super(key: key);

  @override
  _CustomerServiceDialogState createState() => _CustomerServiceDialogState();
}

class _CustomerServiceDialogState extends State<CustomerServiceDialog> {

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                color: ThemeUtils.getDialogBackgroundColor(context),
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: widget.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.title.isEmpty?SizedBox():Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: AppColors.bgColor,width: 1))
                      ),
                      child: Text(widget.title, style: TextStyle(color: AppColors.mainColor,fontSize: Dimens.font_sp16)),
                  ),
//                  widget.content.isEmpty?SizedBox():Container(
//                      alignment: Alignment.center,
//                      height: 40,
//                      child: Text(widget.content, style: TextStyle(fontSize: Dimens.font_sp14,color: Colors.black))
//                  ),
                  Gaps.vGap10,
                  ListView.builder(
                      shrinkWrap: true,
                      physics: new NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context,int index){
                        return InkWell(
                          onTap: (){
                            AppPush.goBack(context);
                            Utils.launchTelURL(widget.phones[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 20,right: 20),
                            height: 50.0,
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 65.0,
                                  child: AppText(alignment: Alignment.centerLeft,text: index==0?'${widget.content}:':''),
                                ),
                                Expanded(
                                    child: AppText(alignment: Alignment.centerLeft,text: widget.phones[index])
                                ),
                                Container(
                                  width: 30.0,
                                  alignment: Alignment.center,
                                  child: LoadAssetImage('订单-电话',width: 30.0,height: 30.0,radius: 0.0,),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: widget.phones.length,
                  ),
                  Gaps.vGap10,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0 , top: 5.0),
                    child: Row(
                      mainAxisAlignment: widget.isHiddenCancel?MainAxisAlignment.center:MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        widget.isHiddenCancel?SizedBox():Container(
                          width: 110.0,
                          height: 36.0,
                          child: FlatButton(
                            onPressed: () {
                              AppPush.goBack(context);
                            },
                            textColor: AppColors.black87Color,
                            color: AppColors.bgColor,
                            disabledTextColor: Colors.white,
                            disabledColor: AppColors.text_gray_c,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: AppColors.inputBgColor,
                                  width: 0.8,
                                )
                            ),
                            child: Text(
                              widget.cancelText,
                              style: TextStyle(fontSize: Dimens.font_sp14),
                            ),
                          ),
                        ),
                        widget.isHiddenCancel?SizedBox():Gaps.hGap10,
                        Container(
                          width: widget.isHiddenCancel?200:110.0,
                          height: 36.0,
                          child: FlatButton(
                            onPressed: () {
                              AppPush.goBack(context);
                            },
                            textColor: Colors.white,
                            color: AppColors.mainColor,
                            disabledTextColor: Colors.white,
                            disabledColor: AppColors.text_gray_c,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              widget.sureText,
                              style: TextStyle(fontSize: Dimens.font_sp14),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}
