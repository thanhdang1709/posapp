import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/screens/cart/add_note.dart';
import 'package:pos_app/screens/cart/components/cart_item.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';

class CartScreen extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    MasterStore masterStore = Get.find();

    List<Widget> buildCartItem(CartController controller) {
      List<Widget> results = [];
      controller.newCart.forEach(
        (e) {
          results
            ..add(
              InkWell(
                onTap: () {
                  print(e['id']);
                  controller.extendRow(e['id']);
                },
                child: CartItem(
                  productId: e['id'],
                  totalPriceItem: e['totalPrice'],
                  productName: e['name'],
                  quantity: e['countItem'],
                  priceItem: e['priceItem'],
                  totalItem: e['totalItem'],
                ),
              ),
            )
            ..add(Container(height: 1, width: double.infinity));
        },
      );
      return results;
    }

    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 40,
        centerTitle: false,
        title: 'Giỏ hàng',
        actions: [
          Obx(() => controller.selectedCustomer.value.name != null
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.white,
                  )),
                  child: Text(controller.selectedCustomer.value.name, style: TextStyle(fontWeight: FontWeight.w700)),
                )
              : Text('')),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: Icon(
          //     FontAwesome.plus_square,
          //   ),
          // ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Get.toNamed('customer');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                FontAwesome.user_plus,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Obx(() => controller.selectedTable.value.name != null
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.white,
                  )),
                  child: Text(controller.selectedTable.value.name, style: TextStyle(fontWeight: FontWeight.w700)),
                )
              : Text('')),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Get.toNamed('table');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(MdiIcons.tableChair),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                print('refreshed');
                return;
              },
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      ...buildCartItem(controller),
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
            ),
          ),
          Obx(() => Text(controller.note.value.toString())),
          Container(
            height: 70,
            padding: EdgeInsets.all(5),
            // margin: EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0), side: BorderSide(color: Palette.primaryColor)),
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
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Palette.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Obx(() => InkWell(
                                  onTap: () {
                                    Get.toNamed('payment', arguments: {'totalPrice': controller.totalPrice});
                                  },
                                  child: Text(
                                    '${masterStore.cartItem.length} món = ${$Number.numberFormat(masterStore.cartItem.length != 0 ? masterStore.cartItem?.map((element) => element.price)?.reduce((a, b) => a + b) : 0)} đ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Palette.textTitle1(),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10,
          // )
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
                leading: Icon(
                  Icons.note_add,
                  color: Colors.cyan,
                ),
                title: new Text(
                  'Thêm ghi chú',
                  style: TextStyle(color: Colors.cyan),
                ),
                onTap: () {
                  // controller.clearCart();
                  Get.to(AddNoteScreen());
                },
              ),
              new ListTile(
                leading: Icon(Icons.close, color: Colors.red),
                title: new Text(
                  'Xoá giỏ hàng',
                  style: TextStyle(color: Colors.red),
                ),
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
