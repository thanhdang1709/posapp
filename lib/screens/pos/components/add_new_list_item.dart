import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';

class AddNewListItem extends StatelessWidget {
  const AddNewListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('product/add');
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Center(
            child: Icon(
          Icons.add,
          color: Palette.textColorLight,
          size: 50,
        )),
        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
