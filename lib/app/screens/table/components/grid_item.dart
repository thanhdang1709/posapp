import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/widgets/popup/pop_menu.dart';

class CardTableGridItem extends StatefulWidget {
  const CardTableGridItem({
    Key key,
    this.size,
    this.color,
    this.name,
    this.status,
    this.onPressed,
    this.capacity,
    this.colorStatus,
    this.tapDown,
  }) : super(key: key);

  final Size size;
  final Color color;
  final String name;
  final String status;
  final int capacity;
  final Color colorStatus;
  final VoidCallback onPressed;
  final Function tapDown;

  @override
  _CardTableGridItemState createState() => _CardTableGridItemState();
}

class _CardTableGridItemState extends State<CardTableGridItem> with SingleTickerProviderStateMixin {
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
      onTapDown: (details) {
        _tapDown(details);
        widget.tapDown(details);
      },
      onTapUp: _tapUp,
      onTap: widget.onPressed,
      //height: 300,
      // onLongPressStart: _longPress,
      onLongPress: () {
        new PopMenuCustom();
      },
      child: Transform.scale(
        scale: _scale,
        child: Column(children: [
          Flexible(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  height: widget.size.height * .15,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: Image.asset('assets/icons/table.png'),
                  ),
                ),
                // Container(
                //   child: Text(
                //     'Sức chứa: ${widget.capacity ?? 0}',
                //     style: Palette.textStyle().copyWith(color: Palette.primaryColor),
                //   ),
                // )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(.2),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontWeight: FontWeight.bold, color: widget.colorStatus),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Flexible(
                    child: Text(
                      widget.status,
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
