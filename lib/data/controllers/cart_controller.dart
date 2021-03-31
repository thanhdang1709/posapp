import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/table_model.dart';

class CartController extends GetxController {
  MasterStore masterStore = Get.find<MasterStore>();
  int totalPrice;
  int totalItem;
  RxInt discount = 0.obs;
  RxInt extendRowId = 0.obs;
  RxString note = ''.obs;
  RxBool itemExtend = true.obs;
  RxList<dynamic> newCart = [].obs;
  RxList cart = [].obs;
  Map<dynamic, List<dynamic>> newMap;
  Rx<CustomerModel> selectedCustomer = CustomerModel().obs;
  Rx<TableModel> selectedTable = TableModel().obs;
  @override
  void onInit() {
    super.onInit();
    reloadState();
    print(newCart);
    print('init cart controller');
  }

  onCreate() {}

  remoteItemInCart(int id) {
    masterStore.cartItem..assignAll(masterStore.cartItem.where((element) => element.id != id).toList());
    extendRowId.value = 0;
    cart = masterStore.cartItem;
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
      masterStore.cartItem.add(product);
    }
    reloadState();
  }

  decrementCartItem(ProductModel product, int count) {
    for (var i = 0; i < count; i++) {
      masterStore.cartItem.removeAt(masterStore.cartItem.indexWhere((e) => e == product));
    }
    reloadState();
  }

  addToCart(ProductModel product) {
    masterStore.cartItem.add(product);
  }

  addNote(String string) {
    note.value = string;
  }

  clearCart() {
    masterStore.cartItem.clear();
    Get.back();
    reloadState();
    Get.offAllNamed('pos');
  }

  selectCustomer(CustomerModel customer) {
    selectedCustomer.value = customer;
  }

  selecteTable(TableModel table) {
    selectedTable.value = table;
  }

  reloadState() {
    cart = (masterStore.cartItem);
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
    totalPrice = masterStore.cartItem.length != 0 ? masterStore.cartItem.map((element) => element.price).reduce((value, element) => value + element) - discount.value : 0;
    totalItem = cart.length;
  }
}
