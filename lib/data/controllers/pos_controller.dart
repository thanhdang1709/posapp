import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/product_services.dart';

class PosController extends GetxController {
  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  MasterStore masterStore = Get.put<MasterStore>(MasterStore());
  //MasterStore MasterStore = Get.find();
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxInt totalItem = 0.obs;
  RxInt totalPrice = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    print('backnpos');
    // // await getCatelogAll();
    // // await getProductAll();

    // MasterStore.catelogies = catelogies;
    // MasterStore.products = products;
  }

  addToCart(ProductModel product) {
    masterStore.cartItem.add(product);
    totalItem.value = masterStore.cartItem.length;
    totalPrice.value = masterStore.cartItem.map((element) => element.price).reduce((a, b) => a + b);
  }

  getCatelogAll() async {
    var response = (await ProductService().getCategoryAll());
    // print(response);
    if (response != null && response.length != 0) {
      catelogies.assignAll(response.map((e) => CatelogModel.fromJson(e)).toList());
      //print(catelogies[0].name);
    }
  }

  getProductAll() async {
    var response = (await ProductService().getProductAll());
    // print(response);
    if (response != null && response.length != 0) {
      products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
    }
    //print(catelogies[0].name);
  }
}
