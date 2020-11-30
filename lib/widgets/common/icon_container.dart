import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({Key key, this.image, this.text}) : super(key: key);
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            padding: EdgeInsets.all(7),
            height: 30,
            child: Image.asset(image),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Text(text)
        ],
      ),
    );
  }
}
