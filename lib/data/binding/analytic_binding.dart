import 'package:get/get.dart';
import 'package:pos_app/data/controllers/analytic_controller.dart';

class AnalyticBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AnalyticController());
  }
}
