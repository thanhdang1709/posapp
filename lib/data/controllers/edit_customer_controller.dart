import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/services/customer_service.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class EditCustomerController extends GetxController {
  EditCustomerController() {
    oldCustomer = Get.arguments;
    print(oldCustomer);
    nameController.text = oldCustomer.name;
    phoneController.text = oldCustomer.phone;
    addressController.text = oldCustomer.address;
  }
  CustomerModel oldCustomer;
  var imagePickerPath = ''.obs;
  final picker = ImagePicker();
  File selectedImage;
  RxList<CustomerModel> customers = <CustomerModel>[].obs;
  RxList<CustomerModel> searchResults = <CustomerModel>[].obs;

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController searchKeyword = new TextEditingController();

  void updateCustomer() async {
    if (nameController.text.trim() == '') {
      return AppUltils()
          .getSnackBarError(message: 'Vui lòng điền tên khách hàng');
    }
    Map<String, String> data = {
      'name': nameController.text.trim().toString(),
      'phone': phoneController.text.trim().toString(),
      'address': addressController.text.trim().toString(),
      'id': oldCustomer.id.toString(),
    };
    var result =
        await CustomerService().update(file: selectedImage ?? null, data: data);
    nameController.text = '';
    phoneController.text = '';
    addressController.text = '';
    print(result);
    await getAll();
    Get.back();
    //Get.back();
    AppUltils().getSnackBarSuccess(message: 'Cập nhật khách hàng thành công');
  }

  Future getAll() async {
    var response = (await CustomerService().getAll());
    if (response != null && response.length != 0) {
      // customers.assignAll(
      customers
          .assignAll(response.map((e) => CustomerModel.fromJson(e)).toList());
      //);
      // return customers;
    }
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
