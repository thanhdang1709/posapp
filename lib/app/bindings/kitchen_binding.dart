import 'package:get/get.dart';
import './../../app/controllers/kitchen_controller.dart';

class KitchenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(KitchenController());
  }
}
