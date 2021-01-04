
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class AddSwipeWidget extends StatefulWidget {

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool auto;
  final bool loop;
  final SwiperPlugin pagination;
  final EdgeInsets edgeInsets;
  final double height;

  const AddSwipeWidget({
    Key key,
    @required this.itemBuilder,
    this.itemCount = 1,
    this.auto = true,
    this.loop = true,
    this.pagination,
    this.edgeInsets,
    this.height = 150.0
  }) : super(key: key);

  @override
  _AddSwipeWidgetState createState() => _AddSwipeWidgetState();
}

class _AddSwipeWidgetState extends State<AddSwipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.edgeInsets??EdgeInsets.only(left: 16,right: 16),
      margin: EdgeInsets.only(top: 10),
      height: widget.height,
      child: Swiper(
        outer: false,
        loop: widget.loop,
        autoplay: widget.itemCount==1?false:widget.auto,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
        pagination:
        widget.pagination??new SwiperPagination(
            margin: new EdgeInsets.only(left: 5, top: 5,right: 5,bottom: MediaQuery.of(context).padding.bottom+5),
            builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                size: 8.0,
                activeSize: 8.0
            )
        ),
      ),
    );
  }
}
