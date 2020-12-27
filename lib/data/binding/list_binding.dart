import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/data/controllers/list_controller.dart';

class ListProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ListProductController>(ListProductController(), permanent: true);
    Get.put<ProductStore>(ProductStore(), permanent: true);
  }
}
