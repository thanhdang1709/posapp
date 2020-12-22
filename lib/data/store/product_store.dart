import 'package:get/get.dart';
import 'package:pos_app/models/cart_model.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/product_services.dart';

class ProductStore extends GetXState {
  RxString inital = '100'.obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  RxList<ProductModel> cartItem = <ProductModel>[].obs;

  @override
  void initState() async {
    super.initState();
    await getCatelogAll();
    await getProductAll();
  }

  Future getCatelogAll() async {
    var response = (await ProductService().getCatelogAll());
    print(response);
    catelogies
        .assignAll(response.map((e) => CatelogModel.fromJson(e)).toList());
  }

  Future getProductAll() async {
    var response = (await ProductService().getProductAll());
    products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
  }
}
