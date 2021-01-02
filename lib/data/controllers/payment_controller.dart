import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/screens/payment/payment_done.dart';
import 'package:pos_app/services/order_service.dart';

class PaymentController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  int totalPrice;
  int totalItem;
  List<int> listItemId = [];
  ProductStore productStore = Get.find();
  CartController cartController = Get.find();
  @override
  onInit() async {
    super.onInit();
    // ignore: unnecessary_statements
    totalPrice = cartController.totalPrice;
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
      'total_price': totalPrice.toString(),
      'note': cartController.note.value,
      'items':
          json.encode(listItemId).replaceFirst("[", '').replaceFirst("]", '')
    };
    var result = await OrderService().addOrder(data: data);
    // print((result.runtimeType));
    if (result != null) {
      Get.to(PaymentDoneScreen(), arguments: {
        'totalPrice': totalPrice,
        'amountReceive': 0,
        'icon': MdiIcons.clock,
        'order_id': result,
        'status_title': 'Đã thêm vào đơn hàng',
        'color': Colors.grey
      });
    }
  }

  paymentOrder() {}
}
