import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/routes/pages.dart';
import 'package:pos_app/screens/order/list/components/item_order.dart';
import 'package:pos_app/screens/order/list/components/item_order_group_date.dart';
import 'package:pos_app/services/order_service.dart';

class OrderController extends GetxController {
  RxList cartItem = [].obs;
  ProductStore productStore = Get.put(ProductStore());
  RxList orders = [].obs;
  RxMap mapOrders = {}.obs;
  RxInt totalOrderItem = 0.obs;
  RxInt totalOrderPrice = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    cartItem.assignAll(productStore.cartItem.map((element) => element.id).toList());
    await getAll();
    mapOrders.assignAll(groupBy(orders, (obj) => obj.date));
    totalOrderItem.value = orders.length;
    orders.forEach(
      (e) {
        totalOrderPrice.value += e.totalPrice;
      },
    );
  }

  Future getAll() async {
    var response = (await OrderService().getAll());
    if (response != null && response.length != 0) {
      orders.assignAll(response.map((e) => OrderModel.fromJson(e)).toList());
    }
  }

  List<Widget> buildItemName(List<ProductModel> products) {
    List<Widget> lists = [];
    var groupProductById = groupBy(products, (obj) => obj.id);
    groupProductById.forEach((k, v) {
      lists..add(Text('${v.length}x ${v.first.name}'));
    });
    return lists;
  }

  List<Widget> buildListItemOrder(List<dynamic> orders) {
    List<Widget> lists = [];
    orders.forEach((e) {
      lists
        ..add(InkWell(
          onTap: () {
            print(e.note);
            Get.toNamed(Routes.ORDER_DETAIL, arguments: e);
          },
          child: ItemOrder(
            orderPrice: e.products.map((e) => e.price).reduce((a, b) => a + b),
            time: e.createdAt,
            orderCode: e.orderCode,
            listProducts: e.products,
            buildItemName: buildItemName(e.products),
          ),
        ));
    });
    return lists;
  }

  List<Widget> buildOrderItem(Map<dynamic, dynamic> mapOrders) {
    List<Widget> lists = [];
    print(mapOrders);
    mapOrders.forEach(
      (k, v) {
        int totalPrice = 0;
        v.forEach((e) {
          totalPrice += e.products.map((e1) => e1.price)?.reduce((a, b) => a + b);
          // v.totalPrice;
        });
        lists
          ..add(
            ItemOrderGroupDate(
              createdAt: v.first.createdAt,
              totalPrice: totalPrice,
              totalQuantity: v.length,
              buildListItemOrder: buildListItemOrder(v),
            ),
          );
      },
    );
    return lists;
  }
}
