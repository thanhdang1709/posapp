import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/ultils/number.dart';

class CardFoodListItem extends StatefulWidget {
  const CardFoodListItem({
    Key key,
    this.size,
    this.color,
    this.title,
    this.price,
    this.imageUrl,
    this.onPressed,
  }) : super(key: key);

  final Size size;
  final Color color;
  final String title;
  final int price;
  final String imageUrl;
  final VoidCallback onPressed;

  @override
  _CardFoodGridItemState createState() => _CardFoodGridItemState();
}

class _CardFoodGridItemState extends State<CardFoodListItem> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 80,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          decoration: BoxDecoration(),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: 100,
              height: 70,
              child: ClipRRect(
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Transform.scale(
                      scale: 0.3,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(value: downloadProgress.progress),
                      )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 70,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    // color: widget.color,
                    //borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: widget.size.width * .3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title[0].toUpperCase() + widget.title.substring(1),
                            style: Palette.textStyle().copyWith(color: Palette.textColor, fontWeight: FontWeight.w200),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${$Number.numberFormat(widget.price).toString()} đ',
                      style: Palette.textStyle().copyWith(color: Palette.textColor, fontWeight: FontWeight.w200),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  _tapUp(TapUpDetails details) {
    Future.delayed(Duration(milliseconds: 150), () {
      _controller.reverse();
    });
  }
}
