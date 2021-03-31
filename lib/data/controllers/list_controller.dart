import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/product_services.dart';

class ListProductController extends GetxController {
  var box = GetStorage();
  MasterStore masterStore = Get.put<MasterStore>(MasterStore());

  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  RxList<CatelogModel> searchCatelogies = <CatelogModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxInt totalStock = 0.obs;
  RxInt totalPrice = 0.obs;
  Timer _debounce;
  TextEditingController searchController = TextEditingController();
  TextEditingController searchCatelogyController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getState();
    searchController.addListener(_onSearchChanged);
    searchCatelogyController.addListener(_onSearchCatelogyChanged);
    //products.firstWhere((element) => element.catelogId == 1);
  }

  getCatelogAll() async {
    var response = (await ProductService().getCategoryAll());
    if (response != null && response.length != 0) {
      catelogies.assignAll(response.map((e) => CatelogModel.fromJson(e)).toList());
    }
    //print(catelogies[0].name);
  }

  getProductAll() async {
    var response = (await ProductService().getProductAll());
    if (response != null && response.length != 0) {
      products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
      return products;
    }

    //print(catelogies[0].name);
  }

  addCatelog(Map<String, String> data) async {
    var idCatelog = await ProductService().addCatelog(data);
    List<String> listCatelogies = [];
    catelogies.map((e) => listCatelogies.add(e.name));
    box.write('catelog', listCatelogies);
    // Get.reset();
    getCatelogAll();
    masterStore.catelogies = catelogies;
    return idCatelog;
  }

  deleteCatelog(id) async {
    var idCatelog = await ProductService().deleteCatelog(id);
    Get.reset();
    getCatelogAll();
    return idCatelog;
  }

  getState() {
    products = masterStore.products;
    catelogies = masterStore.catelogies;
    totalStock.value = products.length != 0 ? products.map((m) => (m.stock))?.reduce((a, b) => a + b) : 0;
    totalPrice.value = products.length != 0 ? products.map<int>((m) => (m.stock * m.price))?.reduce((value, element) => value + element) : 0;
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text != '') {
        masterStore.searchProducts.assignAll(
          masterStore.products.where(
            (element) => element.name.toLowerCase().contains(searchController.text.toLowerCase()),
          ),
        );
      } else {
        masterStore.searchProducts.clear();
      }
    });
  }

  _onSearchCatelogyChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchCatelogyController.text != '') {
        searchCatelogies.assignAll(
          catelogies.where(
            (element) => element.name.toLowerCase().contains(searchCatelogyController.text.toLowerCase()),
          ),
        );
      } else {
        searchCatelogies.clear();
      }
    });
  }
}
