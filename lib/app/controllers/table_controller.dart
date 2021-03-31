import 'package:flutter/cupertino.dart';
import 'package:fma/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/services/table_services.dart';

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

  onSubmit() async {
    isSubmiting.value = true;
    isDisableSubmit.value = true;
    Map<String, dynamic> body = {'name': nameAreaController.text, 'description': descriptionAreaController.text};
    if (nameAreaController.text.isEmpty)
      notify.info(title: 'Thất bại', message: 'Vui lòng điền đầy đủ thông tin');
    else {
      var res = await TableService().addArea(body: body);
      if (res != null) {
        masterStore.areaList..add(res);
        Get.offAllNamed('table');
        notify.success(title: "Thành công", message: "Thêm khu thành công");
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
      'status': statusTable.value,
      'area_id': selectAreaId,
    };
    if (nameAreaController.text.isEmpty) notify.info(title: 'Thất bại', message: 'Vui lòng điền đầy đủ thông tin');
    if (selectAreaId.value == 0)
      notify.info(title: 'Thất bại', message: 'Vui lòng chọn khu vực');
    else {
      var res = await TableService().addTable(body: body);
      if (res != null) {
        masterStore.listTable.add(res);
        Get.offAllNamed('table');
        notify.success(title: "Thành công", message: "Thêm bàn thành công");
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
}
