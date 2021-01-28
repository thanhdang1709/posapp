import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/repositories/notification_service.dart';
import 'package:pos_app/services/product_services.dart';

class SplashController extends GetxController {
  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  ProductStore productStore = Get.put<ProductStore>(ProductStore());
  RxList<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() async {
    super.onInit();

    await getCatelogAll();
    await getProductAll();

    productStore.catelogies = catelogies;
    productStore.products = products;

    PushNotificationsManager().init();
    // if (catelogies.length != 0 && catelogies.length != 0)
    Get.offAllNamed('pos');
  }

  Future getCatelogAll() async {
    var response = await ProductService().getCatelogAll();
    print(response);
    if (response != null && response.length != 0) {
      catelogies.assignAll(response.map((e) => CatelogModel.fromJson(e)).toList());
    }
  }

  Future getProductAll() async {
    var response = (await ProductService().getProductAll());
    if (response != null && response.length != 0) {
      products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
    }
  }
}
