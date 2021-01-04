
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../../public_header.dart';

enum BarMode{
  defaultMode,
  notEdit,
}

class AppMainSearchBar extends StatefulWidget implements PreferredSizeWidget{

  final Widget leftWidget;
  final Widget rightWidget;
  final String hintText;
  final Function onPressed;
  final double radius;
  final double height;
  final BarMode mode;
  final Color bgColor;
  final Color tfBgColor;
  final TextEditingController textField;
  final FocusNode focusNode;

  final Function backPressed;
  final Function searchPressed;

  const AppMainSearchBar({
    Key key,
    this.leftWidget,
    this.rightWidget,
    this.hintText = '搜索',
    this.onPressed,
    this.radius = 20.0,
    this.height = 40.0,
    this.mode = BarMode.defaultMode,
    this.backPressed,
    this.searchPressed,
    this.bgColor = AppColors.transparentColor,
    this.tfBgColor = AppColors.bgColor,
    @required this.textField,
    @required this.focusNode
  }) : super(key: key);

  @override
  _AppMainSearchBarState createState() => _AppMainSearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(48.0);

}

class _AppMainSearchBarState extends State<AppMainSearchBar> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void didUpdateWidget(AppMainSearchBar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    Color iconColor = isDark ? AppColors.dark_text_gray : AppColors.text_gray_c;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Material(
        color: widget.bgColor,
        child: SafeArea(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  createLeftWidget(),
                  createMode(isDark, iconColor),
                  createRightWidget(),
                ],
              ),
            )
        ),
      ),
    );
  }


  createMode(bool isDark, Color iconColor){
    switch (widget.mode) {
      case BarMode.defaultMode:
        {
          return createCenterWidget(isDark, iconColor);
        }
        break;
      case BarMode.notEdit:
        {
          return createCenterNotEditWidget(isDark, iconColor);
        }
        break;
      default:
        {

        }
        break;
    }
  }

  ///默认的编辑模式
  createCenterWidget(bool isDark, Color iconColor){
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 10,right: 0),
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDark ? AppColors.dark_material_bg : widget.tfBgColor,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: TextField(
          key: const Key('srarch_text_field'),
//          autofocus: true,
          controller: widget.textField,
          focusNode: widget.focusNode,
          maxLines: 1,
          textInputAction: TextInputAction.search,
          onSubmitted: (val) {
            // 点击软键盘的动作按钮时的回调
            widget.onPressed(val);
          },
          decoration: InputDecoration(
//                  contentPadding: const EdgeInsets.only(top: 0.0, left: -8.0, right: -16.0, bottom: 14.0),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: new OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
              child: LoadAssetImage(
                '搜索',
                color: iconColor,
                width: 17,
                height: 17,
                radius: 0.0,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: Dimens.font_sp12,color: AppColors.black54Color),
            suffixIcon: GestureDetector(
              child: Semantics(
                label: '清空',
                child: Container(width: 20,alignment: Alignment.center,child: LoadAssetImage('删除灰色',width: 15,height: 15,radius: 0.0,)),
              ),
              onTap: () {
                /// https://github.com/flutter/flutter/issues/35848
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  widget.textField.text = '';
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  ///不可编辑模式
  createCenterNotEditWidget(bool isDark, Color iconColor){
    return Expanded(
      child: InkWell(
        onTap: (){
          widget.onPressed('1');
        },
        child: Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          height: widget.height,
          decoration: BoxDecoration(
            color: isDark ? AppColors.dark_material_bg : widget.tfBgColor,
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              LoadAssetImage(
                '搜索',
                color: iconColor,
                width: 17,
                height: 17,
              ),
              Gaps.hGap12,
              Text('搜索',style: TextStyle(fontSize: Dimens.font_sp12,color: AppColors.black54Color),)
            ],
          ),
        ),
      ),
    );
  }

  createLeftWidget(){
    return InkWell(
      onTap: (){
        widget.backPressed();
      },
      child: widget.leftWidget??Container(
        width: 50.0,
        alignment: Alignment.center,
        child: LoadAssetImage('ic_back_black',width: 25,height: 25,),
      ),
    );
  }

  createRightWidget(){
    return InkWell(
        onTap: () {
          widget.focusNode.unfocus();
          widget.searchPressed();
        },
        child: widget.rightWidget??SizedBox(width: 20,)
    );
  }
}
