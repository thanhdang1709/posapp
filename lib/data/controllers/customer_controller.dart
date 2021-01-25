import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/services/customer_service.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class CustomerController extends GetxController {
  var imagePickerPath = ''.obs;
  final picker = ImagePicker();
  File selectedImage;
  RxList<CustomerModel> customers = <CustomerModel>[].obs;
  RxList<CustomerModel> searchResults = <CustomerModel>[].obs;

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController searchKeyword = new TextEditingController();

  Timer _debounce;
  RxBool isSearchActive = false.obs;
  RxBool isLoading = true.obs;
  @override
  onInit() async {
    super.onInit();
    await getAll();
    //print(customers);
    print('onInit agrument');
    searchKeyword.addListener(_onSearchChanged);
    print(isLoading.value);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('onReady');
  }

  void submit() async {
    if (nameController.text.trim() == '') {
      return AppUltils().getSnackBarError(message: 'Vui lòng điền tên khách hàng');
    }
    Map<String, dynamic> data = {
      'name': nameController.text.trim().toString(),
      'phone': phoneController.text.trim().toString(),
      'address': addressController.text.trim().toString(),
    };
    // ignore: unused_local_variable
    var result = await CustomerService().addProduct(file: selectedImage ?? null, data: data);
    nameController.text = '';
    phoneController.text = '';
    addressController.text = '';

    await getAll();
    Get.back();
    //Get.back();
    AppUltils().getSnackBarSuccess(message: 'Thêm khách hàng thành công');
  }

  Future getAll() async {
    isLoading.value = true;

    var response = (await CustomerService().getAll());
    if (response != null && response.length != 0) {
      // customers.assignAll(
      customers.assignAll(response.map((e) => CustomerModel.fromJson(e)).toList());
      isLoading.value = false;
      //);
      // return customers;
    }
    isLoading.value = false;
  }

  deleteCustomer(int id) async {
    print(id);
    var response = (await CustomerService().delete(id));
    if (response != null && response.length != 0) {
      print('deleteOk');
      customers.removeAt(customers.indexWhere((e) => e.id == id));

      Get.back();
      Get.back();
      AppUltils().getSnackBarSuccess(message: 'Xoá khách hàng thành công');
    } else {
      AppUltils().getSnackBarError(message: 'Có lỗi xảy ra vui lòng thử lại sau');
    }
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with _searchQuery.text
      print(searchKeyword.text);
      if (searchKeyword.text != '') {
        searchResults.assignAll(
          customers.where(
            (element) => element.name.toLowerCase().contains(searchKeyword.text.toLowerCase()),
          ),
        );
      } else {
        searchResults.clear();
      }
    });
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
