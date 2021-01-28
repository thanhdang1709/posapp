import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/repositories/common.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/services/product_services.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class LoginController extends GetxController {
  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  ProductStore productStore = Get.put<ProductStore>(ProductStore());
  RxList<ProductModel> products = <ProductModel>[].obs;

  login(body) async {
    var response = await http.post('$BASE_URL/api/login', body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    print(response.body);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['token'].isNotEmpty) {
          var box = GetStorage();
          box.write('token', result['token']);
          box.write('user_info', result['user']);
          box.write('store_name', result['user']['store_name']);
          box.write('phone', result['user']['phone']);
          box.write('name', result['user']['name']);
          box.write('role', result['user']['role']);
          box.write('address', result['user']['store'] ?? result['user']['address']);
          box.write('email', result['user']['store'] ?? result['user']['email']);
          box.write('logo', result['user']['store'] ?? result['user']['logo']);
          await getCatelogAll();
          await getProductAll();

          productStore.catelogies = catelogies;
          productStore.products = products;
          // if (catelogies.length != 0 && catelogies.length != 0)
          Get.offAllNamed('pos');
          AppUltils().getSnackBarSuccess(title: 'Thành công', message: 'Đăng nhập thành công');
        }
      }
    } else {
      AppUltils().getSnackBarError(title: 'Thất bại', message: 'Đăng nhập thất bại, vui lòng thử lại');
    }
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
