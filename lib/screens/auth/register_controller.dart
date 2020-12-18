import 'dart:convert';
import 'package:get/get.dart';
import 'package:pos_app/repositories/common.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/ultils/app_ultils.dart';

class RegisterController extends GetxController {
  register(body) async {
    // var response = await UserRepo().postRegister(body);
    // print(response.body);
    var response = await http.post('$BASE_URL/register',
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['alert'] == 'success' && result['code'] == 200) {
          Get.toNamed('/welcome');
          AppUltils().getSnackBarSuccess(
              message: 'Đăng ký tài khoản thành cồng, mời đăng nhập');
        }
      }
    } else {
      AppUltils().getSnackBarError(
          message: 'Đăng ký tài khoản thất bại, vui lòng thử lại');
    }
  }
}
