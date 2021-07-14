import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/app/controllers/table_controller.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/models/area_model.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/button/button_submit.dart';
import 'package:pos_app/widgets/text_input.dart';

class EditTableScreen extends GetView<TableController> {
  //CustomerController customerController = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    TableController controller = Get.put(TableController());
    controller.nameTableController.text = controller.selectedTable.name;
    controller.nameTableController.text = controller.selectedTable.name;
    controller.descriptionTableController.text = controller.selectedTable.description;
    controller.selectAreaId.value = controller.selectedTable.areaId;
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: CONTANTS.HEIGHT_APPBAR,
        title: 'label.add_new_table'.tr,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: MyTextInput(
                              controller: controller.nameTableController,
                              hintText: 'label.table_name'.tr,
                              iconData: null,
                              hintColor: Colors.black,
                              rules: {
                                'required': 'Vui lòng điền tên bàn',
                                'minLength': 3,
                              },
                              validateCallback: (e) {
                                controller.isValidateNameTable.value = e;
                                controller.onValidateTable();
                              },
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            // color: Palette.secondColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 60,
                          padding: EdgeInsets.only(left: 10),
                          child: DropdownSearch<AreaModel>(
                            dropdownSearchDecoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            mode: Mode.BOTTOM_SHEET,
                            showSelectedItem: false,
                            showSearchBox: true,
                            isFilteredOnline: true,
                            selectedItem: controller.masterStore.areaList.firstWhere((e) => e.id == controller.selectedTable.areaId, orElse: null) ?? controller.masterStore.areaList.first,
                            items: controller.masterStore.areaList,
                            hint: 'label.select_area'.tr,
                            onChanged: (e) {
                              controller.selectAreaId.value = e.id;
                            },
                            itemAsString: (AreaModel u) => u.name.toString(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            // color: Palette.secondColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 60,
                          padding: EdgeInsets.only(left: 10),
                          child: DropdownSearch<Map>(
                            dropdownSearchDecoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            mode: Mode.BOTTOM_SHEET,
                            showSelectedItem: false,
                            showSearchBox: true,
                            isFilteredOnline: true,
                            selectedItem: [
                              {
                                "id": 1,
                                "name": "Sẵn sàng",
                              },
                              {
                                "id": 2,
                                "name": "Tạm ngưng",
                              },
                            ].firstWhere((e) => e['id'] == controller.selectedTable.status, orElse: null),
                            items: [
                              {
                                "id": 1,
                                "name": "Sẵn sàng",
                              },
                              {
                                "id": 2,
                                "name": "Tạm ngưng",
                              },
                            ],
                            hint: 'common.status'.tr,
                            onChanged: (e) {},
                            itemAsString: (Map u) => u['name'].toString(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         child: MyTextInput(
                        //       controller: controller.capacityController,
                        //       textInputType: TextInputType.number,
                        //       hintText: 'label.capacity'.tr,
                        //       iconData: null,
                        //       hintColor: Colors.black,
                        //     ))
                        //   ],
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: MyTextInput(
                              controller: controller.descriptionAreaController,
                              hintText: 'common.description'.tr,
                              iconData: null,
                              maxLines: 5,
                              hintColor: Colors.black,
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButtonSubmit(
                label: 'Sửa'.tr,
                submiting: controller.isSubmiting.value,
                onPressed: controller.isDisableSubmit.value ? null : controller.oonSubmitUpdateTable,
              )))
        ],
      ),
    );
  }
}
