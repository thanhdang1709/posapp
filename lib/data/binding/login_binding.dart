import 'package:get/get.dart';
import 'package:pos_app/screens/auth/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
