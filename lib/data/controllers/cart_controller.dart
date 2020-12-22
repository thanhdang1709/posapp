import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/product_model.dart';

class CartController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  ProductStore productStore = Get.find<ProductStore>();
  int totalPrice;
  int totalItem;
  int discount = 0;
  RxInt extendRowId = 0.obs;

  List<Map> newCart = [];
  @override
  void onInit() {
    super.onInit();

    var cart = (productStore.cartItem);
    var newMap = groupBy(cart, (obj) => obj.id);
    newMap.values.forEach((element) {
      newCart
        ..add({
          'id': element.first.id,
          'priceItem': element.first.price,
          'countItem': element.length,
          'name': element.first.name,
          'totalPrice': element.map((e) => e.price).reduce((a, b) => a + b)
        });
    });

    totalPrice = productStore.cartItem
            .map((element) => element.price)
            .reduce((value, element) => value + element) -
        discount;
    totalItem = cart.length;

    print(newCart);
  }

  extendRow(int id) {
    extendRowId.value = id;
  }

  addToCart(ProductModel product) {
    productStore.cartItem.add(product);
  }

  clearCart() {
    productStore.cartItem.clear();
    Get.back();
    Get.offAllNamed('pos');
  }
}
