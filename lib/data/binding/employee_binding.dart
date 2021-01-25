import 'package:get/get.dart';
import 'package:pos_app/data/controllers/employee_controller.dart';

class EmployeeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(EmployeeController());
  }
}
