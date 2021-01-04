import 'package:demo/public_header.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  final Function onChange;
  final Function onClear;
  final Function onSubmitted;
  final Color bgColor;
  final Function onTab;
  final bool enable;
  const SearchBar(
      {Key key,
      this.hintText: "您在哪儿上车？",
      this.onChange,
      this.onClear,
      this.onSubmitted,
      this.bgColor,
      this.onTab, this.enable:true})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController mTextEditingController = new TextEditingController();
  FocusNode mFocusNode = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: widget?.bgColor ?? Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      alignment: Alignment.center,
      height: 40,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
//          new Icon(Icons.motorcycle,size: 20,color: AppColors.greenColor,),
          new Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: AppColors.greenColor
            ),
          ),
          new SizedBox(
            width: 5,
          ),
          new Expanded(
            child: new Stack(
              children: [
                TextField(
                  enabled: widget?.enable,
                  onTap: widget?.onTab,
                  onChanged: (text) {
                    setState(() {});
                    if (widget?.onChange != null) {
                      widget?.onChange(text);
                    }
                  },
                  controller: mTextEditingController,
                  maxLines: 1,
                  style: new TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 12,
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (str) {
                    if (widget?.onSubmitted != null) {
                      widget?.onSubmitted(str);
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10),
                    //border:InputBorder.none,不居中
                    border: new OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: widget.hintText,
                    hintStyle: new TextStyle(
                        fontSize: 14, textBaseline: TextBaseline.alphabetic),
                  ),
                ),
                new Positioned(
                  child: new Offstage(
                    offstage: mTextEditingController.text.length == 0,
                    child: new InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        mTextEditingController.text = "";
                        setState(() {});
                        if (widget?.onClear != null) {
                          widget?.onClear();
                        }
                      },
                      child: new Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        child: new Text('取消',style: TextStyle(fontSize: 14,color: AppColors.orangeColor),),
                      ),
                    ),
                  ),
                  right: 0,
                  top: 0,
                  bottom: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
