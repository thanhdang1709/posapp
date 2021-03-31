import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/area_model.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:pos_app/services/product_services.dart';
import 'package:pos_app/services/table_services.dart';

class InitData {
  RxList<CatelogModel> catelogies = <CatelogModel>[].obs;
  MasterStore masterStore = Get.put<MasterStore>(MasterStore());
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<AreaModel> areaList = <AreaModel>[].obs;
  RxList<TableModel> listTable = <TableModel>[].obs;
  GetStorage box = GetStorage();

  onInit() async {
    await getCatelogAll();
    await getProductAll();
    await getListrea();
    await getListTable();

    masterStore.catelogies = catelogies;
    masterStore.products = products;
    masterStore.areaList = areaList;
    masterStore.listTable = listTable;
  }

  Future getCatelogAll() async {
    var response = await ProductService().getCategoryAll();
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

  Future getListrea() async {
    var res = await TableService().getListrea();
    if (res != null) {
      areaList.assignAll(res);
    }
  }

  Future getListTable() async {
    var res = await TableService().getListTable();
    if (res != null) {
      listTable.assignAll(res);
    }
  }
}
