import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/product_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PosController extends GetxController {
  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  MasterStore masterStore = Get.put<MasterStore>(MasterStore());
  RefreshController refreshController = RefreshController(initialRefresh: false);

  //MasterStore MasterStore = Get.find();
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxInt totalItem = 0.obs;
  RxInt totalPrice = 0.obs;
  RxString barCodeScan = ''.obs;
  TextEditingController searchPosController = TextEditingController();
  RxList<ProductModel> searchResult = <ProductModel>[].obs;
  Timer _debounce;
  RxBool isLoading = false.obs;
  RxBool isListItem = false.obs;
  @override
  void onInit() async {
    super.onInit();
    print('backnpos');
    // // await getCatelogAll();
    //  await getProductAll();

    // MasterStore.catelogies = catelogies;
    products = (masterStore.products);
    searchPosController.addListener(_onSearchProduct);
  }

  addToCart(ProductModel product) {
    masterStore.cartItem.add(product);
    totalItem.value = masterStore.cartItem.length;
    totalPrice.value = masterStore.cartItem.map((element) => element.price).reduce((a, b) => a + b);
  }

  getCatelogAll() async {
    isLoading.value = true;
    var response = (await ProductService().getCategoryAll());
    // print(response);
    if (response != null && response.length != 0) {
      catelogies.assignAll(response.map((e) => CatelogModel.fromJson(e)).toList());
      //print(catelogies[0].name);
    }
    isLoading.value = false;
  }

  getProductAll() async {
    var response = (await ProductService().getProductAll());
    // print(response);
    if (response != null && response.length != 0) {
      products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
    }
    //print(catelogies[0].name);
  }

  _onSearchProduct() {
    isLoading.value = true;
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (searchPosController.text != '') {
        isLoading.value = false;
      } else {
        searchResult.clear();
        isLoading.value = false;
      }
    });
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver('#ff6666', 'Huỷ bỏ', true, ScanMode.BARCODE).listen((barcode) {
      barCodeScan.value = barcode.toString();

      if (barCodeScan.isNotEmpty) searchPosController.text = barcode;
    });

    // ignore: unused_element
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Huỷ bỏ', true, ScanMode.BARCODE);
      barCodeScan.value = barcodeScanRes;
      if (barCodeScan.isNotEmpty && barCodeScan.value != '-1') searchPosController.text = barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await getProductAll();
    refreshController.refreshCompleted();
  }
}
