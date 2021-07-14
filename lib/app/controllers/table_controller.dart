import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fma/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos_app/app/screens/table/area/list/list.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/area_model.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:pos_app/services/table_services.dart';
import 'package:pos_app/widgets/common/dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TableController extends GetxController with GetTool {
  TextEditingController nameAreaController = new TextEditingController();
  TextEditingController descriptionAreaController = new TextEditingController();

  TextEditingController nameTableController = new TextEditingController();
  TextEditingController descriptionTableController = new TextEditingController();
  TextEditingController capacityController = new TextEditingController();

  RxInt statusTable = 1.obs;
  RxInt selectAreaId = 0.obs;

  RxBool isDisableSubmit = true.obs;
  RxBool isSubmiting = false.obs;
  RxBool isValidateName = false.obs;

  RxBool isValidateNameTable = false.obs;
  MasterStore masterStore = Get.put(MasterStore());

  RxList<AreaModel> areaList = <AreaModel>[].obs;
  RxList<TableModel> listTable = <TableModel>[].obs;

  AreaModel selectedArea;
  TableModel selectedTable;

  RxBool isLoading = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  PagingController<int, AreaModel> pagingController = PagingController(firstPageKey: 0);
  TextEditingController searchKeyword = new TextEditingController();

  onInit() async {
    super.onInit();
    await getListrea();
    await getListTable();

    masterStore.areaList.assignAll(areaList);
    masterStore.listTable.assignAll(listTable);

    pagingController.addPageRequestListener((pageKey) {
      _handleGetList(pageKey);
    });
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    pagingController.refresh();
  }

  void onRefreshTable() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await getListTable();
    masterStore.listTable = (listTable);
    refreshController.refreshCompleted();
  }

  _handleGetList(pageKey) async {
    final res = await TableService().getListrea(page: pageKey, limit: CONTANTS.LIMIT);
    if (res != null) {
      List<AreaModel> list = res;
      bool isLastPage = list.length < CONTANTS.LIMIT;
      if (isLastPage) {
        pagingController.appendLastPage(list);
      } else {
        pagingController.appendPage(list, pageKey + 1);
      }
      refreshController.refreshCompleted();
    } else {
      notify.error(title: 'common.failure'.tr, message: "Có lỗi xảy ra, vui lòng thử lại", timeout: 30000);
      refreshController.loadFailed();
    }
    // totalCustomer.value = pagingController.itemList.length;
  }

  onSubmit() async {
    isLoading.value = true;
    isSubmiting.value = true;
    isDisableSubmit.value = true;
    Map<String, dynamic> body = {'name': nameAreaController.text, 'description': descriptionAreaController.text};
    if (nameAreaController.text.isEmpty)
      notify.info(title: 'Thất bại', message: 'Vui lòng điền đầy đủ thông tin');
    else {
      var res = await TableService().addArea(body: body);
      if (res != null) {
        await getListrea();
        masterStore.areaList = areaList;
        //masterStore.areaList..assign(res);
        Get.offAllNamed('table');
        Get.to(AreaScreen());
        nameAreaController.clear();
        descriptionAreaController.clear();
        pagingController.refresh();
        notify.success(title: "Thành công", message: "Thêm khu vực thành công");
      }
    }
    isLoading.value = false;
    isSubmiting.value = false;
    isDisableSubmit.value = false;
  }

  onUpdateArea() async {
    isLoading.value = true;
    isSubmiting.value = true;
    isDisableSubmit.value = true;
    Map<String, dynamic> body = {'name': nameAreaController.text, 'description': descriptionAreaController.text};
    if (nameAreaController.text.isEmpty) {
      notify.info(title: 'Thất bại', message: 'Vui lòng điền đầy đủ thông tin');
      return;
    } else {
      var res = await TableService().updateArea(id: selectedArea.id, body: body);
      if (res != null) {
        await getListrea();
        masterStore.areaList = areaList;
        //masterStore.areaList..assign(res);
        Get.offAllNamed('table');
        Get.to(AreaScreen());
        nameAreaController.clear();
        descriptionAreaController.clear();
        pagingController.refresh();
        notify.success(title: "Thành công", message: "Sửa khu vực thành công");
      }
    }
    isLoading.value = false;
    isSubmiting.value = false;
    isDisableSubmit.value = false;
  }

  oonSubmitUpdateTable() async {
    isSubmiting.value = true;
    isDisableSubmit.value = true;
    Map<String, dynamic> body = {
      'name': nameTableController.text,
      'description': descriptionAreaController.text,
      'capacity': capacityController.text,
      'status': statusTable.value,
      'area_id': selectAreaId,
    };
    if (nameTableController.text.isEmpty) {
      notify.info(title: 'Thất bại', message: 'Vui lòng điền đầy đủ thông tin');
      isSubmiting.value = false;
      isDisableSubmit.value = false;
      return;
    }
    if (selectAreaId.value == 0) {
      notify.info(title: 'Thất bại', message: 'Vui lòng chọn khu vực');
      isSubmiting.value = false;
      isDisableSubmit.value = false;
      return;
    } else {
      var res = await TableService().updateTable(id: selectedTable.id, body: body);
      if (res != null) {
        await getListTable();
        masterStore.listTable = listTable;
        Get.offAllNamed('table');
        notify.success(title: "Thành công", message: "Sửa bàn thành công");
        nameTableController.clear();
        descriptionAreaController.clear();
      }
    }
    isSubmiting.value = false;
    isDisableSubmit.value = false;
  }

  onSubmitAddTable() async {
    isSubmiting.value = true;
    isDisableSubmit.value = true;
    Map<String, dynamic> body = {
      'name': nameTableController.text,
      'description': descriptionAreaController.text,
      'capacity': capacityController.text,
      'status': statusTable.value,
      'area_id': selectAreaId,
    };
    if (nameTableController.text.isEmpty) {
      notify.info(title: 'Thất bại', message: 'Vui lòng điền đầy đủ thông tin');
      isSubmiting.value = false;
      isDisableSubmit.value = false;
      return;
    }
    if (selectAreaId.value == 0) {
      notify.info(title: 'Thất bại', message: 'Vui lòng chọn khu vực');
      isSubmiting.value = false;
      isDisableSubmit.value = false;
      return;
    } else {
      var res = await TableService().addTable(body: body);
      if (res != null) {
        masterStore.listTable.insert(0, res);
        Get.offAllNamed('table');
        notify.success(title: "Thành công", message: "Thêm bàn thành công");
        nameTableController.clear();
        descriptionAreaController.clear();
      }
    }
    isSubmiting.value = false;
    isDisableSubmit.value = false;
  }

  onValidate() {
    isDisableSubmit.value = true;
    if (isValidateName.value) {
      isDisableSubmit.value = false;
      return false;
    } else {
      isDisableSubmit.value = true;
      return false;
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

  onValidateTable() {
    isDisableSubmit.value = true;
    if (isValidateNameTable.value) {
      isDisableSubmit.value = false;
      return false;
    } else {
      isDisableSubmit.value = true;
      return false;
    }
  }
  // onConfirmTable(){
  //   notify.success()
  // }

  onDeleteTable(TableModel table) async {
    DialogConfirm()
        .info(
          context: Get.context,
          title: "Bạn có chắc chắn?",
          desc: "Xoá bàn là không thể phục hồi",
        )
        .onCancel(
          text: "Đóng lại",
        )
        .onConfirm(
          text: "Đồng ý",
          onPress: () async {
            var res = await TableService().deleteTable(tableId: table.id);
            print(res);
            if (res != null) {
              masterStore.listTable.remove(table);
              Get.offAllNamed('table');
              notify.success(title: 'Thành công', message: "Xoá bàn ${table.name} thành công");
            }
          },
        )
        .show(hideIcon: false);
  }

  onDeleteArea(AreaModel area) async {
    isLoading.value = true;
    DialogConfirm()
        .info(
          context: Get.context,
          title: "Bạn có chắc chắn?",
          desc: "Xoá khu vực là không thể phục hồi",
        )
        .onCancel(
          text: "Đóng lại",
        )
        .onConfirm(
          text: "Đồng ý",
          onPress: () async {
            var res = await TableService().deleteArea(areaId: area.id);
            print(res);
            if (res != null) {
              isLoading.value = false;
              pagingController.refresh();
              await getListrea();
              Get.offAllNamed('table');
              Get.to(AreaScreen());
              masterStore.areaList = areaList;
              notify.success(title: 'Thành công', message: "Xoá khu vực ${area.name} thành công");
            }
          },
        )
        .show(hideIcon: false);
    isLoading.value = false;
  }
}
