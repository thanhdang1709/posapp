import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fma/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/services/customer_service.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerController extends GetxController with GetTool {
  var imagePickerPath = ''.obs;
  final picker = ImagePicker();
  File selectedImage;
  RxList<CustomerModel> customers = <CustomerModel>[].obs;
  RxList<CustomerModel> searchResults = <CustomerModel>[].obs;
  RxBool isLoading = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  PagingController<int, CustomerModel> pagingController = PagingController(firstPageKey: 0);

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController searchKeyword = new TextEditingController();

  RxInt totalCustomer = 0.obs;
  Timer _debounce;
  @override
  onInit() async {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _handleGetList(pageKey);
    });
    totalCustomer.value = pagingController.itemList.length;
    searchKeyword.addListener(_onSearchChanged);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('onReady');
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    pagingController.refresh();
  }

  _handleGetList(pageKey) async {
    final res = await CustomerService().getAll(page: pageKey, limit: CONTANTS.LIMIT);
    if (res != null) {
      List<CustomerModel> list = res;
      bool isLastPage = list.length < CONTANTS.LIMIT;
      if (isLastPage) {
        pagingController.appendLastPage(list);
      } else {
        pagingController.appendPage(list, pageKey + 1);
      }
      refreshController.refreshCompleted();
    } else {
      notify.error(title: 'common.failure'.tr, message: "Có lỗi xảy ra, vui lòng thử lại", timeout: 30000);
      refreshController.loadFailed();
    }
    totalCustomer.value = pagingController.itemList.length;
  }

  _handleSearch(pageKey) async {
    final res = await CustomerService().getAll(page: pageKey, limit: CONTANTS.LIMIT);
    if (res != null) {
      List<CustomerModel> list = res;
      bool isLastPage = list.length < CONTANTS.LIMIT;
      if (isLastPage) {
        pagingController.appendLastPage(list);
      } else {
        pagingController.appendPage(list, pageKey + 1);
      }
      refreshController.refreshCompleted();
    } else {
      notify.error(title: 'common.failure'.tr, message: "Có lỗi xảy ra, vui lòng thử lại", timeout: 30000);
      refreshController.loadFailed();
    }
    totalCustomer.value = pagingController.itemList.length;
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
    print(data.runtimeType);
    var result = await CustomerService().addProduct(file: selectedImage ?? null, data: Map<String, dynamic>.from(data));
    nameController.text = '';
    phoneController.text = '';
    addressController.text = '';

    pagingController.refresh();
    Get.back();
    //Get.back();
    AppUltils().getSnackBarSuccess(message: 'Thêm khách hàng thành công');
  }

  Future getAll() async {
    isLoading.value = true;

    var response = (await CustomerService().getAll());
    if (response != null && response.length != 0) {
      customers.assignAll(response);
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  deleteCustomer(int id) async {
    print(id);
    var response = (await CustomerService().delete(id));
    if (response != null && response.length != 0) {
      customers.removeAt(customers.indexWhere((e) => e.id == id));
      Get.back();
      Get.back();
      AppUltils().getSnackBarSuccess(message: 'Xoá khách hàng thành công');
    } else {
      AppUltils().getSnackBarError(message: 'Có lỗi xảy ra vui lòng thử lại sau');
    }
  }

  _onSearchChanged() {
    isLoading.value = true;
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchKeyword.text != '') {
        searchResults.assignAll(
          pagingController.itemList.where(
            (element) => element.name.toLowerCase().contains(searchKeyword.text.toLowerCase()),
          ),
        );
      } else {
        searchResults.clear();
      }
      print(searchResults);
    });
    isLoading.value = false;
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
