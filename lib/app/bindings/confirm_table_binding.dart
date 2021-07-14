import 'package:get/get.dart';
import './../../app/controllers/confirm_table_controller.dart';

class ConfirmTableBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ConfirmTableController());
  }
}
