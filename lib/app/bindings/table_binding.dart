import 'package:get/get.dart';
import './../../app/controllers/table_controller.dart';

class TableBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TableController(), permanent: false);
  }
}
