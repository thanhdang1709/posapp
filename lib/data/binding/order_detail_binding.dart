import 'package:get/get.dart';
import 'package:pos_app/data/controllers/order_detail_controller.dart';

class OrderDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OrderDetailController());
  }
}
