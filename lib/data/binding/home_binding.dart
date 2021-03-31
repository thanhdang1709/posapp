import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/data/controllers/splash_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(), permanent: true);
    Get.put<MasterStore>(MasterStore(), permanent: true);
  }
}
