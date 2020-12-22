import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/screens/cart/components/cart_item.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';

class CartScreen extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    // ProductStore productStore = Get.find();

    List<Widget> buildCartItem(newCart) {
      List<Widget> results = [];
      newCart.forEach((e) {
        results
          ..add(CartItem(
            totalPriceItem: e['totalPrice'],
            productName: e['name'],
            quality: e['countItem'],
          ))
          ..add(Container(height: 1, width: double.infinity));
      });
      return results;
    }

    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 50,
        centerTitle: false,
        title: 'Giỏ hàng',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              FontAwesome.plus_square,
              color: Colors.cyan,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              FontAwesome.user_plus,
              color: Colors.cyan,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...buildCartItem(controller.newCart),
                  RowTotalPrice(
                    totalPrice: controller.totalPrice,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: Get.height * .1,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  height: Get.height * 1 - 10,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Pallate.primaryColor)),
                      //color: Colors.grey[300],
                      onPressed: () {
                        cartModalBottomSheet(context);
                      },
                      child: Icon(Icons.more_horiz)),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Pallate.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${controller.totalItem} món = ${$Number.numberFormat(controller.totalPrice)} đ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Pallate.textTitle1(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  cartModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: Icon(Icons.note_add),
                title: new Text('Thêm ghi chú'),
                onTap: () {
                  // controller.clearCart();
                },
              ),
              new ListTile(
                leading: Icon(Icons.close),
                title: new Text('Xoá giỏ hàng'),
                onTap: () {
                  controller.clearCart();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
