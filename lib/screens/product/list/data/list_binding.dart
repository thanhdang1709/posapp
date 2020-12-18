import 'package:get/get.dart';
import 'package:pos_app/screens/product/list/data/list_controller.dart';

class ListProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ListProductController>(ListProductController(), permanent: true);
  }
}
