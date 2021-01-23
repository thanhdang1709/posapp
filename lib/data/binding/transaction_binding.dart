import 'package:get/get.dart';
import 'package:pos_app/data/controllers/order_controller.dart';
import 'package:pos_app/data/controllers/transaction_controller.dart';

class TransactionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TransactionController());
    Get.put(OrderController());
  }
}
