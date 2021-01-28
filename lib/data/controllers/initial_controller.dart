import 'package:get/get.dart';
import 'package:pos_app/repositories/notification_service.dart';

class InitialController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await PushNotificationsManager().init();
  }
}
