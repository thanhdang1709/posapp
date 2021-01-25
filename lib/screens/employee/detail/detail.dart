import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/customer_controller.dart';
import 'package:pos_app/data/controllers/edit_customer_controller.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/repositories/common.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/image/image_circle.dart';

// ignore: must_be_immutable
class CustomerDetailScreen extends GetView<EditCustomerController> {
  CustomerModel customer;
  @override
  Widget build(BuildContext context) {
    customer = Get.arguments;
    CustomerController customerController = Get.put(CustomerController());
    EditCustomerController controller = Get.put(EditCustomerController());

    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 40,
        centerTitle: false,
        title: '${customer.name ?? ''}',
        actions: [
          InkWell(
            onTap: () {
              customerController.deleteCustomer(customer.id);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.delete),
            ),
          )
        ],
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
                  Container(
                    height: Get.height * .2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: ClipRRect(
                      child: InkWell(
                        onTap: () {
                          // ignore: unnecessary_statements
                          controller.addImageModalBottomSheet(context);
                        },
                        child: Obx(
                          () => controller.imagePickerPath.value == ''
                              ? customer.avatar == null
                                  ? Transform.scale(
                                      scale: 0.6,
                                      child: Image.asset(
                                        'assets/icons/picture.png',
                                        // height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ImageCircle(
                                      width: Get.height * .2,
                                      image: "$BASE_DOMAIN/${customer.avatar}",
                                    )
                              : Container(
                                  color: Colors.blueGrey,
                                  //  padding: const EdgeInsets.all(20.0),
                                  child: Image.file(
                                    File(controller.imagePickerPath.value),
                                    width: Get.height * .2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(100),
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
                                controller: controller.nameController,
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
                                controller: controller.phoneController,
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
                                controller: controller.addressController,
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
                controller.updateCustomer();
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
