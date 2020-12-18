import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/product_services.dart';

class ListProductController extends GetxController {
  var box = GetStorage();
  ProductStore productStore = Get.put<ProductStore>(ProductStore());

  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxInt totalStock = 0.obs;
  RxInt totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    products = productStore.products;
    catelogies = productStore.catelogies;
    totalStock.value =
        products.map<int>((m) => (m.stock)).reduce((a, b) => a + b);
    totalPrice.value = products
        .map<int>((m) => (m.stock * m.price))
        .reduce((value, element) => value + element);

    //products.firstWhere((element) => element.catelogId == 1);
  }

  getCatelogAll() async {
    var response = (await ProductService().getCatelogAll());
    print(response);
    catelogies
        .assignAll(response.map((e) => CatelogModel.fromJson(e)).toList());
    //print(catelogies[0].name);
  }

  getProductAll() async {
    var response = (await ProductService().getProductAll());
    print(response);
    products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
    return products;
    //print(catelogies[0].name);
  }

  addCatelog(data) async {
    var idCatelog = await ProductService().addCatelog(data);
    List<String> listCatelogies = [];
    catelogies.map((e) => listCatelogies.add(e.name));
    box.write('catelog', listCatelogies);
    // Get.reset();
    getCatelogAll();
    productStore.catelogies = catelogies;
    return idCatelog;
  }

  deleteCatelog(id) async {
    var idCatelog = await ProductService().deleteCatelog(id);
    Get.reset();
    getCatelogAll();
    return idCatelog;
  }
}
