import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/product_model.dart';

class CartController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  ProductStore productStore = Get.find<ProductStore>();
  int totalPrice;
  int totalItem;
  RxInt discount = 0.obs;
  RxInt extendRowId = 0.obs;
  RxString note = ''.obs;
  RxBool itemExtend = true.obs;
  RxList<dynamic> newCart = [].obs;
  RxList cart = [].obs;
  Map<dynamic, List<dynamic>> newMap;

  @override
  void onInit() {
    super.onInit();
    reloadState();
  }

  onCreate() {}

  remoteItemInCart(int id) {
    productStore.cartItem
      ..assignAll(
          productStore.cartItem.where((element) => element.id != id).toList());
    extendRowId.value = 0;
    cart = productStore.cartItem;
    newMap = groupBy(cart, (obj) => obj.id);
    newMap.removeWhere((key, value) => key == id);
    // newCart = null;
    reloadState();
  }

  extendRow(int id) {
    extendRowId.value = id;
  }

  incrementCartItem(ProductModel product, int count) {
    for (var i = 0; i < count; i++) {
      productStore.cartItem.add(product);
    }
    reloadState();
  }

  decrementCartItem(ProductModel product, int count) {
    for (var i = 0; i < count; i++) {
      productStore.cartItem
          .removeAt(productStore.cartItem.indexWhere((e) => e == product));
    }
    reloadState();
  }

  addToCart(ProductModel product) {
    productStore.cartItem.add(product);
  }

  clearCart() {
    productStore.cartItem.clear();
    Get.back();
    Get.offAllNamed('pos');
  }

  reloadState() {
    cart = (productStore.cartItem);
    newMap = groupBy(cart, (obj) => obj.id);
    newCart.clear();
    newMap.values.forEach(
      (element) {
        newCart
          ..add(
            {
              'id': element.first.id,
              'priceItem': element.first.price,
              'countItem': element.length,
              'name': element.first.name,
              'totalPrice': element.map((e) => e.price).reduce((a, b) => a + b),
              'totalItem': element.length,
            },
          );
      },
    );
    totalPrice = productStore.cartItem.length != 0
        ? productStore.cartItem
                .map((element) => element.price)
                .reduce((value, element) => value + element) -
            discount.value
        : 0;
    totalItem = cart.length;
  }
}
