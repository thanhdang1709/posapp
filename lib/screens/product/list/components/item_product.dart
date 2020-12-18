import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/image/image_container.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({Key key, this.product}) : super(key: key);

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: Get.height * .1,
      child: Row(
        children: [
          ContainerImageProduct(
            imageUrl: 'https://xemhd.xyz/' + product.imageUrl,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              product.name,
              style: Pallate.titleProduct(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text('${$Number.numberFormat(product.price)} vnđ'),
        ],
      ),
    );
  }
}
