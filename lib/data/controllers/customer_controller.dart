import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app/services/customer_service.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class CustomerController extends GetxController {
  var imagePickerPath = ''.obs;
  final picker = ImagePicker();
  File selectedImage;

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  @override
  onInit() {
    super.onInit();
  }

  void submit() async {
    if (nameController.text.trim() == '') {
      return AppUltils()
          .getSnackBarError(message: 'Vui lòng điền tên khách hàng');
    }
    print('hello');
    Map<String, String> data = {
      'name': nameController.text.trim().toString(),
      'phone': phoneController.text.trim().toString(),
      'address': addressController.text.trim().toString(),
    };
    print(data.runtimeType);
    var result = await CustomerService()
        .addProduct(file: selectedImage ?? null, data: data);
    print(result);
    Get.back();
    Get.back();
  }

  addImageModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: Image.asset(
                  'assets/icons/camera.png',
                  height: 30,
                ),
                title: new Text('Chụp ảnh'),
                onTap: () {
                  //Get.to(AddPostScreen());
                  getImage(from: ImageSource.camera);
                },
              ),
              new ListTile(
                leading: Image.asset(
                  'assets/icons/picture.png',
                  height: 30,
                ),
                title: new Text('Chọn từ thư viện'),
                onTap: () {
                  getImage(from: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage({ImageSource from}) async {
    final pickedFile = await picker.getImage(source: from, imageQuality: 100);
    if (pickedFile != null) {
      imagePickerPath.value = (pickedFile.path);
      selectedImage = File(pickedFile.path);
      Get.back();
    } else {
      print('No image selected.');
    }
  }
}
