import 'package:get/get.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/controllers/payment_controller.dart';
import 'package:pos_app/data/store/product_store.dart';

class PaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController());
    Get.put<MasterStore>(MasterStore(), permanent: true);
    Get.put(CartController());
  }
}
