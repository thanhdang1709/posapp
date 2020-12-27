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
  RxInt totalItem = 0.obs;
  RxInt totalPrice = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    print('backnpos');
    await getCatelogAll();
    await getProductAll();

    productStore.catelogies = catelogies;
    productStore.products = products;
  }

  addToCart(ProductModel product) {
    productStore.cartItem.add(product);
    totalItem.value = productStore.cartItem.length;
    totalPrice.value = productStore.cartItem
        .map((element) => element.price)
        .reduce((a, b) => a + b);
  }

  getCatelogAll() async {
    var response = (await ProductService().getCatelogAll());
    // print(response);
    if (response != null && response.length != 0) {
      catelogies
          .assignAll(response.map((e) => CatelogModel.fromJson(e)).toList());
      //print(catelogies[0].name);
    }
  }

  getProductAll() async {
    var response = (await ProductService().getProductAll());
    // print(response);
    if (response != null && response.length != 0) {
      products
          .assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
    }
    //print(catelogies[0].name);
  }
}
