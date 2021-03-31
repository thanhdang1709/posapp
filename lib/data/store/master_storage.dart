import 'package:get_storage/get_storage.dart';
import 'package:pos_app/models/config_model.dart';
import 'package:pos_app/models/store_model.dart';
import 'package:pos_app/models/user_model.dart';

class MasterConfig {
  GetStorage box;

  MasterConfig() {
    this.box = GetStorage();
  }

  // factory MasterConfig.config() {
  //   return MasterConfig();
  // }
  UserModel get userInfo => box.hasData('user') ? UserModel.fromJson(box.read('user')) : null;
  StoreModel get storeInfo => box.hasData('store_info') ? StoreModel.fromJson(box.read('store_info')) : null;
  ConfigModel get configInfo => ConfigModel.fromJson(box.read('config_info'));
}
