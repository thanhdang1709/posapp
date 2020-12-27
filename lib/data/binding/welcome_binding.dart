import 'package:get/get.dart';
import 'package:pos_app/data/controllers/initial_controller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InitialController());
  }
}
