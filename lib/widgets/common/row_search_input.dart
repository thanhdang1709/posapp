import 'package:flutter/material.dart';
import 'package:pos_app/config/pallate.dart';

class RowSearchInput extends StatelessWidget {
  const RowSearchInput(
      {Key key, this.iconRight, this.hintText, this.onPressIcon})
      : super(key: key);

  final IconData iconRight;
  final String hintText;
  final Function onPressIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.search,
          size: 30,
          color: Colors.black54,
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: hintText ?? 'Tìm sản phẩm'),
          ),
        ),
        InkWell(
          onTap: onPressIcon ?? () {},
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              iconRight ?? Icons.add,
              size: 30,
              color: Pallate.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
