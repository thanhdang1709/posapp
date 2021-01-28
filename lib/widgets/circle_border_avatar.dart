import 'package:flutter/material.dart';

class CircleBorderAvatar extends StatelessWidget {
  const CircleBorderAvatar({
    Key key,
    this.imageUrl,
    this.height,
    this.width,
  }) : super(key: key);
  final String imageUrl;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        border: Border.all(color: Colors.orange, width: 1),
        boxShadow: [
          BoxShadow(
              color: Color(0x332222CC),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset.fromDirection(0, 0)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(400),
        child: Image.network(
          imageUrl,
          height: height ?? 400,
          width: width ?? 400,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
