import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/screens/receipt/receipt.dart';
import 'package:pos_app/services/order_service.dart';

class ReceiptController extends GetxController {
  Rx<OrderModel> order = new OrderModel().obs;
  RxInt totalOrderItem = 0.obs;
  RxInt totalOrderPrice = 0.obs;
  RxInt totalMenu = 0.obs;
  RxString orderCode = ''.obs;
  RxList<dynamic> products = [].obs;
  Map<dynamic, List<dynamic>> mapProducts;

  @override
  onReady() async {
    super.onReady();
    var response = await getOrderById(Get.arguments);
    order.value = (response);
    products.assignAll(order.value.products);
    mapProducts = groupBy(products, (obj) => obj.id);
    totalMenu.value = mapProducts.length;
    totalOrderItem.value = products.length;
    orderCode.value = order.value.orderCode;
  }

  Future<OrderModel> getOrderById(id) async {
    var result = await OrderService().getOrder(id);
    return OrderModel.fromJson(result);
  }

  List<Widget> buildRowItem() {
    List<Widget> lists = [];
    mapProducts?.forEach(
      (k, v) {
        lists.add(
          RowItemReCeipt(
            productName: v[0].name,
            productPrice: v[0].price,
            quantity: v.length,
          ),
        );
      },
    );
    return lists;
  }

  var random = Random().nextInt(10000);
  write(pdf) async {
    final Directory directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory();
    final File file = File('${directory.path}/${random}_my_file.pdf');
    await file.writeAsBytes(await pdf.save());
    return '${directory.path}/${random}_my_file.pdf';
  }

  Future<String> read() async {
    String text;
    try {
      final Directory directory = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getApplicationSupportDirectory();
      final File file = File('${directory.path}/my_file.pdf');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }
}
