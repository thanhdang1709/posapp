import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/customer_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class AddCustomerScreen extends GetView<CustomerController> {
  CustomerController customerController = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 40,
        title: 'Khách hàng mới',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: Get.height * .2,
                    color: Colors.grey[300],
                    child: Center(
                      child: ClipRRect(
                        child: InkWell(
                          onTap: () {
                            // ignore: unnecessary_statements
                            customerController
                                .addImageModalBottomSheet(context);
                            print('hello');
                          },
                          child: Obx(() =>
                              customerController.imagePickerPath.value == ''
                                  ? Container(
                                      color: Colors.blueGrey,
                                      padding: const EdgeInsets.all(20.0),
                                      child: Transform.scale(
                                        scale: 0.7,
                                        child: Image.asset(
                                          'assets/icons/picture.png',
                                          height: 50,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      color: Colors.blueGrey,
                                      //  padding: const EdgeInsets.all(20.0),
                                      child: Image.file(
                                        File(customerController
                                            .imagePickerPath.value),
                                        //height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: customerController.nameController,
                                decoration: InputDecoration(
                                    labelText: 'Tên khách hàng *'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: customerController.phoneController,
                                decoration:
                                    InputDecoration(labelText: 'Điện thoại'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller:
                                    customerController.addressController,
                                decoration: InputDecoration(
                                    labelText: 'Địa chỉ (tuỳ chọn)',
                                    suffixIcon: Icon(
                                      FontAwesome.chevron_right,
                                      size: 20,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // ignore: unnecessary_statements
                customerController.submit();
              },
              child: Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Pallate.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'LƯU',
                      style:
                          GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
