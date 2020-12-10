import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';

class ItemCatelog extends StatelessWidget {
  const ItemCatelog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .1,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Pha chế',
              style: Pallate.titleProduct(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.menu,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
