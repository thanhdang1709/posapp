import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/ultils/number.dart';

class CardFoodGridItem extends StatefulWidget {
  const CardFoodGridItem({
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

class _CardFoodGridItemState extends State<CardFoodGridItem>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 150,
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
      //height: 300,
      child: Transform.scale(
        scale: _scale,
        child: Column(children: [
          Flexible(
            flex: 2,
            child: Container(
              height: widget.size.height * .15,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Transform.scale(
                          scale: 0.3,
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Pallate.textColorLight),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Flexible(
                    child: Text(
                      '${$Number.numberFormat(widget.price).toString()} đ',
                      style: TextStyle(color: Pallate.textColorLight),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
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
