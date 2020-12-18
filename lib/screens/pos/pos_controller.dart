import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/product_services.dart';

class PosController extends GetxController {
  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  ProductStore productStore = Get.put<ProductStore>(ProductStore());
  //ProductStore productStore = Get.find();
  RxList<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    // getCatelogAll();
    // getProductAll();
    catelogies.addAll(productStore.catelogies);
    products.addAll(productStore.products);
  }

  getCatelogAll() async {
    var response = (await ProductService().getCatelogAll());
    // print(response);
    catelogies
        .assignAll(response.map((e) => CatelogModel.fromJson(e)).toList());
    //print(catelogies[0].name);
  }

  getProductAll() async {
    var response = (await ProductService().getProductAll());
    // print(response);
    products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());

    //print(catelogies[0].name);
  }
}
