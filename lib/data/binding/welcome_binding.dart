import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/data/controllers/initial_controller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InitialController());
  }
}
