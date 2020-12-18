import 'package:get/get.dart';
import 'package:pos_app/repositories/common.dart';

class UserRepo extends GetConnect {
  // Get request
  Future<Response> getAllUsers() => get('$BASE_URL/users', headers: {});
  // Post request
  Future postRegister(Map<String, dynamic> data) =>
      post('$BASE_URL/register', data);
}
