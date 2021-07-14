import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/app/controllers/table_controller.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/button/button_submit.dart';
import 'package:pos_app/widgets/text_input.dart';

class DetailAreaScreen extends GetView<TableController> {
  //CustomerController customerController = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    TableController controller = Get.put(TableController());
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: CONTANTS.HEIGHT_APPBAR,
        title: 'label.add_new_area'.tr,
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
                              controller: controller.nameAreaController,
                              hintText: 'label.area_name'.tr,
                              iconData: null,
                              hintColor: Colors.black,
                              rules: {
                                'required': 'Vui lòng điền tên khu vực',
                                'minLength': 3,
                              },
                              validateCallback: (e) {
                                controller.isValidateName.value = e;
                                controller.onValidate();
                              },
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Palette.secondColor.withOpacity(0.2),
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
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: TextFormField(
                        //         controller: controller.addressController,
                        //         decoration: InputDecoration(
                        //             labelText: 'Địa chỉ (tuỳ chọn)',
                        //             suffixIcon: Icon(
                        //               FontAwesome.chevron_right,
                        //               size: 20,
                        //             )),
                        //       ),
                        //     )
                        //   ],
                        // ),
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
                label: 'common.add'.tr,
                submiting: controller.isSubmiting.value,
                onPressed: controller.isDisableSubmit.value ? null : controller.onSubmit,
              )))
        ],
      ),
    );
  }
}
