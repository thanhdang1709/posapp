import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/screens/pos/pos_controller.dart';

class PosBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PosController>(PosController(), permanent: true);
    Get.put<ProductStore>(ProductStore(), permanent: true);
  }
}
