import 'package:get/get.dart';
import 'package:pos_app/data/controllers/receipt_controller.dart';

class ReceiptBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ReceiptController());
  }
}
