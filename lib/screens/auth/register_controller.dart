import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fma/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:pos_app/repositories/common.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController with GetTool {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController shopNameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  RxBool isDisableSubmit = true.obs;
  RxBool isSubmitting = false.obs;

  RxBool isValidateName = false.obs;
  RxBool isValidateEmail = false.obs;
  RxBool isValidatePhone = false.obs;
  RxBool isValidateShopName = false.obs;
  RxBool isValidateAddress = false.obs;
  RxBool isValidatePassword = false.obs;

  onValidate() {
    if (isValidateName.value && isValidateEmail.value && isValidateShopName.value && isValidatePhone.value && isValidateAddress.value && isValidatePassword.value) {
      isDisableSubmit.value = false;
    } else {
      isDisableSubmit.value = true;
    }
  }

  handleSubmit() async {
    isSubmitting.value = true;
    isDisableSubmit.value = true;
    Map<String, dynamic> body = {
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'name': nameController.text.trim(),
      'address': addressController.text.trim(),
      'store_name': shopNameController.text.trim(),
      'store_id': Uuid().v4(),
      'password': passwordController.text.trim(),
    };
    await RegisterController().register(body);
    isSubmitting.value = false;
    isDisableSubmit.value = false;
  }

  Future register(body) async {
    var response = await http.post('$BASE_URL/api/register', body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        print(response.body);
        var result = jsonDecode(response.body);
        if (result['message'] == 'success' && result['code'] == 200) {
          Get.toNamed('welcome');
          AppUltils().getSnackBarSuccess(message: 'Đăng ký tài khoản thành công, mời đăng nhập');
          notify.success(title: 'Thành công', message: 'Đăng ký tài khoản thành công, mời đăng nhập');
        }
      }
    } else {
      // AppUltils().getSnackBarError(message: 'Đăng ký tài khoản thất bại, vui lòng thử lại');
      notify.error(title: 'Thất bại', message: 'Đăng ký tài khoản thất bại, mời thử lại');
    }
  }
}
