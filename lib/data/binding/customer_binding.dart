import 'package:get/get.dart';
import 'package:pos_app/data/controllers/customer_controller.dart';

class CustomerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CustomerController(), permanent: true);
    //Get.lazyPut(() => CustomerController());
  }
}
