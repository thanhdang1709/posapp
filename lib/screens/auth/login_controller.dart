import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/repositories/common.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/ultils/app_ultils.dart';

class LoginController extends GetxController {
  login(body) async {
    var response = await http.post('$BASE_URL/login',
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['token'].isNotEmpty) {
          Get.offAllNamed('/pos');
          var box = GetStorage();
          box.write('token', result['token']);
          box.write('user_info', result['user']);
          box.write('shop_name', result['user']['shop_name']);
          box.write('name', result['user']['name']);
          AppUltils().getSnackBarSuccess(
              title: 'Thành công', message: 'Đăng nhập thành công');
        }
      }
    } else {
      AppUltils().getSnackBarError(
          title: 'Thất bại', message: 'Đăng nhập thất bại, vui lòng thử lại');
    }
  }
}
