import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/repositories/common.dart';
import 'package:pos_app/screens/product/edit/edit.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/image/image_container.dart';

class ItemProductStock extends StatelessWidget {
  const ItemProductStock({Key key, this.product}) : super(key: key);

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
        height: Get.height * .1,
        margin: EdgeInsets.only(bottom: 15),
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
            Text($Number.numberFormat(product.stock)),
          ],
        ),
      ),
    );
  }
}
