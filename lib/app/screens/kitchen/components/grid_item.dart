import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';

class KithenItem extends StatefulWidget {
  const KithenItem({
    Key key,
    this.size,
    this.color,
    this.name,
    this.status,
    this.onPressed,
    this.capacity,
    this.colorStatus,
  }) : super(key: key);

  final Size size;
  final Color color;
  final String name;
  final String status;
  final int capacity;
  final Color colorStatus;
  final VoidCallback onPressed;

  @override
  _KithenItemState createState() => _KithenItemState();
}

class _KithenItemState extends State<KithenItem> with SingleTickerProviderStateMixin {
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
        child: Row(children: [
          Flexible(
            flex: 2,
            child: Container(
              height: Get.height * .15,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: Image.asset('assets/icons/table.png'),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Palette.primaryColor.withOpacity(.3),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, color: widget.colorStatus),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Flexible(
                    child: Text(
                      widget.status ?? '',
                      style: TextStyle(color: widget.colorStatus),
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
