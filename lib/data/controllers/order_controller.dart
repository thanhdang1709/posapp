import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/services/order_service.dart';

class OrderController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  RxList cartItem = [].obs;
  ProductStore productStore = Get.put(ProductStore());

  @override
  void onInit() {
    super.onInit();
    cartItem
        .assignAll(productStore.cartItem.map((element) => element.id).toList());
    print(cartItem);
    getAll();
  }

  Future getAll() async {
    var response = (await OrderService().getAll());
    if (response != null && response.length != 0) {
      var result = response.map((e) => OrderModel.fromJson(e)).toList();
      // print(result[0].items[0].name);
    }
  }
}
