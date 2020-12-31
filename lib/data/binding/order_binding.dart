import 'package:get/get.dart';
import 'package:pos_app/data/controllers/order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OrderController());
  }
}
