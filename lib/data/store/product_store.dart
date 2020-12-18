import 'package:get/get.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/product_services.dart';

class ProductStore extends GetXState {
  RxString inital = '100'.obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  //List<CatelogModel> catelogies;

  @override
  void initState() async {
    super.initState();
    //  print(inital);
    await getCatelogAll();
    getProductAll();
    // catelogies = await getCatelogAll()
    //     .then((res) => res.map((e) => CatelogModel.fromJson(e)).toList());
    // Future.delayed(Duration(seconds: 3), () {
    //   if (catelogies.length != 0) Get.toNamed('pos');
    // });
  }

  Future getCatelogAll() async {
    var response = (await ProductService().getCatelogAll());
    // return response;
    print(response);
    catelogies
        .assignAll(response.map((e) => CatelogModel.fromJson(e)).toList());
  }

  Future getProductAll() async {
    var response = (await ProductService().getProductAll());
    // print(response);
    products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
  }
}
