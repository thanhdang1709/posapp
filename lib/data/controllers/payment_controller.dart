import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/screens/payment/payment_done.dart';
import 'package:pos_app/services/order_service.dart';

class PaymentController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  RxInt totalPrice = 0.obs;
  RxInt totalItem = 0.obs;
  List<int> listItemId = [];
  ProductStore productStore = Get.find();
  CartController cartController = Get.put(CartController());
  RxInt amountReceive = 0.obs;
  RxInt change = 0.obs;
  @override
  onInit() async {
    super.onInit();
    totalPrice.value = cartController.totalPrice;
    cartController.cart.forEach((e) {
      listItemId.add(e.id);
    });
  }

  saveOrder() async {
    Map<String, String> data = {
      'table_id': 1.toString(),
      'customer_id': 1.toString(),
      'status': 0.toString(),
      'amount_receive': 0.toString(),
      'amount_change': 0.toString(),
      'total_price': totalPrice.value.toString(),
      'note': cartController.note.value,
      'items':
          json.encode(listItemId).replaceFirst("[", '').replaceFirst("]", '')
    };
    var result = await OrderService().addOrder(data: data);
    // print((result.runtimeType));
    if (result != null) {
      Get.offAll(PaymentDoneScreen(), arguments: {
        'totalPrice': totalPrice.value,
        'amountReceive': 0,
        'icon': MdiIcons.clock,
        'order_id': result,
        'status_title': 'Đã thêm vào đơn hàng',
        'color': Colors.grey
      });
    }
  }

  paymentOrder(totalPrice, amountReceive) async {
    Map<String, String> data = {
      'table_id': 1.toString(),
      'customer_id': 1.toString(),
      'status': 1.toString(),
      'amount_receive': amountReceive.toString(),
      'amount_change': (amountReceive - totalPrice).toString(),
      'total_price': totalPrice.toString(),
      'note': cartController.note.value,
      'items':
          json.encode(listItemId).replaceFirst("[", '').replaceFirst("]", '')
    };
    var result = await OrderService().addOrder(data: data);
    // print((result.runtimeType));
    if (result != null) {
      Get.offAll(PaymentDoneScreen(), arguments: {
        'totalPrice': totalPrice,
        'amountReceive': (amountReceive - totalPrice),
        'icon': MdiIcons.check,
        'order_id': result,
        'status_title': 'Thanh toán thành công',
        'color': Colors.green
      });
    }
  }
}
