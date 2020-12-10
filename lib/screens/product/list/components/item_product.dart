import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/widgets/image/image_container.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .1,
      child: Row(
        children: [
          ContainerImageProduct(
            imageUrl:
                'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Cà phê',
              style: Pallate.titleProduct(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text('80,000 vnđ'),
        ],
      ),
    );
  }
}
