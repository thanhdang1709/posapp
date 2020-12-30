import 'package:get/get.dart';
import 'package:pos_app/data/controllers/payment_controller.dart';

class PaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController());
  }
}
