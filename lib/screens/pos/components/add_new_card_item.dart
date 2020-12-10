import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/screens/product/list/list.dart';

class AddNewCardItem extends StatelessWidget {
  const AddNewCardItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ListProductScreen());
      },
      child: Container(
        child: Center(
            child: Icon(
          Icons.add,
          color: Pallate.textColorLight,
          size: 40,
        )),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}