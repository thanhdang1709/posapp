import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/screens/product/edit/edit.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/image/image_container.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({Key key, this.product}) : super(key: key);

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            EditProductScreen(
              product: product,
            ),
            arguments: product);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: Get.height * .1,
        child: Row(
          children: [
            ContainerImageProduct(
              imageUrl: product.imageUrl,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                product.name,
                style: Palette.titleProduct(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text('${$Number.numberFormat(product.price)} đ'),
          ],
        ),
      ),
    );
  }
}
