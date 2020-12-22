import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/store/product_store.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
    Get.put(ProductStore());
  }
}
