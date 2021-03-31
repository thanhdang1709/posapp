import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/screens/payment/payment_done.dart';
import 'package:pos_app/services/order_service.dart';

class PaymentController extends GetxController {
  RxInt totalPrice = 0.obs;
  RxInt totalItem = 0.obs;
  List<int> listItemId = [];
  MasterStore masterStore = Get.find();
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
    Map<String, dynamic> data = {
      'table_id': cartController.selectedTable.value.id,
      'customer_id': cartController.selectedCustomer.value.id == null ? "0" : cartController.selectedCustomer.value.id.toString(),
      'status': 0.toString(),
      'status_title': 'pending',
      'amount_receive': 0.toString(),
      'amount_change': 0.toString(),
      'total_price': totalPrice.value.toString(),
      'note': cartController.note.value,
      'items': json.encode(listItemId).replaceFirst("[", '').replaceFirst("]", '')
    };
    var result = await OrderService().addOrder(data: data);
    // print((result.runtimeType));
    if (result != null) {
      Get.offAll(PaymentDoneScreen(),
          arguments: {'totalPrice': totalPrice.value, 'amountReceive': 0, 'icon': MdiIcons.clock, 'order_id': result, 'status_title': 'Đã thêm vào đơn hàng', 'color': Colors.grey});
    }
  }

  paymentOrder(totalPrice, amountReceive) async {
    Map<String, dynamic> data = {
      'table_id': cartController.selectedTable.value.id,
      'customer_id': cartController.selectedCustomer.value.id == null ? "0" : cartController.selectedCustomer.value.id.toString(),
      'status': 1.toString(),
      'status_title': 'payment',
      'amount_receive': amountReceive.toString(),
      'amount_change': (amountReceive - totalPrice).toString(),
      'total_price': totalPrice.toString(),
      'note': cartController.note.value,
      'items': json.encode(listItemId).replaceFirst("[", '').replaceFirst("]", '')
    };
    var result = await OrderService().addOrder(data: data);
    // print((result.runtimeType));
    if (result != null) {
      Get.back();
      Get.offAll(PaymentDoneScreen(),
          arguments: {'totalPrice': totalPrice, 'amountReceive': (amountReceive), 'icon': MdiIcons.check, 'order_id': result, 'status_title': 'Thanh toán thành công', 'color': Colors.green});
    }
  }

  updatePaymentOrder(orderId, totalPrice, amountReceive) async {
    Map<String, String> data = {
      'order_id': orderId.toString(),
      'amount_receive': amountReceive.toString(),
      'customer_id': cartController.selectedCustomer.value.id == null ? "0" : cartController.selectedCustomer.value.id.toString(),
      'amount_change': (amountReceive - totalPrice).toString(),
      'total_price': totalPrice.toString(),
      'status_title': 'payment',
      'status': 1.toString(),
    };
    var result = await OrderService().updatePayment(data: data);
    print((result.runtimeType));
    Get.back();
    if (result != null) {
      Get.back();
      Get.offAll(PaymentDoneScreen(), arguments: {
        'totalPrice': totalPrice,
        'amountReceive': (amountReceive),
        'icon': MdiIcons.check,
        'order_id': int.tryParse(result['order_id']),
        'status_title': 'Thanh toán thành công',
        'color': Colors.green
      });
    }
  }
}
