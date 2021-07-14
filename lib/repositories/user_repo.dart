import 'package:get/get.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/repositories/common.dart';

class UserRepo extends GetConnect {
  // Get request
  Future<Response> getAllUsers() => get('${CONTANTS.BASE_DOMAIN}/users', headers: {});
  // Post request
  Future postRegister(Map<String, dynamic> data) => post('${CONTANTS.BASE_DOMAIN}/register', data);
}
