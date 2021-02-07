

import 'package:flutter/material.dart';

import '../../public_header.dart';


class AppUserHeaderItem extends StatefulWidget {
  final String header;
  final double size;
  final String title;
  final Function onPress;

  const AppUserHeaderItem({Key key, this.header = '', this.size = 50, this.title = '', this.onPress}) : super(key: key);

  @override
  _AppUserHeaderItemState createState() => _AppUserHeaderItemState();
}

class _AppUserHeaderItemState extends State<AppUserHeaderItem> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      height: widget.size,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(widget.title,style: TextStyle(fontSize: Dimens.font_sp14,color: ThemeUtils.isDark(context)?AppColors.whiteColor:AppColors.blackColor),),
            ),
          ),
          InkWell(
            onTap: widget.onPress,
            child: ClipOval(
              child: Container(
                alignment: Alignment.center,
                width: widget.size-20,
                  height: widget.size-20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(widget.size/2.0)),
                      border: Border.all(color: AppColors.black33Color,width: 1)
                  ),
                  child: LoadImage(widget.header??"",width: widget.size-20,height: widget.size-20,radius: 0.0,)
              ),
            ),
          )
        ],
      ),
    );
  }
}
