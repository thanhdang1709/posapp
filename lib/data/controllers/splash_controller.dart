import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/data/controllers/initData_controller.dart';
import 'package:pos_app/repositories/notification_service.dart';
import 'package:pos_app/screens/welcome/onboarding_page.dart';

class SplashController extends GetxController {
  GetStorage box = GetStorage();
  @override
  void onInit() async {
    super.onInit();

    PushNotificationsManager().init();

    if (box.hasData('token')) {
      await InitData().onInit();
      await Future.delayed(Duration(seconds: 1), () {
        print(box.read('token'));
        Get.offAllNamed('pos');
      });
    } else {
      if (box.hasData('first_visit')) {
        await Future.delayed(Duration(seconds: 1), () {
          Get.offAllNamed('welcome');
        });
      } else {
        await Future.delayed(Duration(seconds: 1), () {
          Get.to(OnBoardingPage());
        });
      }
    }
  }
}
