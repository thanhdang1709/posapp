import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/order_detail_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:intl/intl.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/tab_view/tab_heading.dart';

import 'package:sliding_button/sliding_button.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  @override
  Widget build(BuildContext context) {
    //print(controller.order.value.to);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Obx(
        () => !controller.isLoading.value
            ? Scaffold(
                appBar: AppUltils.buildAppBar(
                  height: 50,
                  centerTitle: false,
                  title: DateFormat('dd/MM/yyyy - hh:mm').format(controller.order.value.createdAt),
                  actions: [
                    Get.previousRoute == '/transaction'
                        ? InkWell(
                            onTap: () {
                              Get.offNamed('receipt', arguments: controller.order.value.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.print,
                                size: 30,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
                body: Obx(
                  () => !controller.isLoading.value
                      ? Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              $Number.numberFormat(controller.order.value.totalPrice) + ' đ',
                                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Pallate.primaryColor),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Get.previousRoute == '/transaction'
                                                ? Text('Đã thanh toán',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                    ))
                                                : Text(controller.order.value.status.last.title)
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Text(
                                              '#' + controller.order.value.orderCode,
                                              style: TextStyle(color: Colors.blue),
                                            ),
                                            Text(
                                              controller.order.value.employee.name,
                                              style: TextStyle(color: Colors.cyan),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: controller.order.value.note != null && controller.order.value.note != ''
                                        ? Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Ghi chú: ' + controller.order.value.note,
                                              )),
                                            ],
                                          )
                                        : Get.previousRoute == '/transaction'
                                            ? Container()
                                            : InkWell(
                                                onTap: () {
                                                  print('add note event');
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.add),
                                                    Text('Thêm ghi chú'),
                                                  ],
                                                ),
                                              ),
                                  ),
                                  TabHeading(controller: controller),
                                  Expanded(
                                    child: controller.order.value.customer != null
                                        ? TabBarView(
                                            controller: controller.tabController,
                                            children: [
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [...controller.buildItemName(controller.order.value.products)],
                                                ),
                                              ),
                                              SingleChildScrollView(child: Column(children: [...controller.buildTimeLineStatus(controller.order.value.status, controller.order.value)])),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                    margin: EdgeInsets.only(top: 20),
                                                    // height: 100,
                                                    //alignment: Alignment.center,
                                                    decoration: BoxDecoration(border: Border.all(color: Pallate.primaryColor)),
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                      controller.order.value.customer.name,
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Pallate.primaryColor),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  )),
                                                ],
                                              )
                                            ],
                                          )
                                        : TabBarView(
                                            controller: controller.tabController,
                                            children: [
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [...controller.buildItemName(controller.order.value.products)],
                                                ),
                                              ),
                                              SingleChildScrollView(child: Column(children: [...controller.buildTimeLineStatus(controller.order.value.status, controller.order.value)])),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Get.previousRoute == 'order'
                                ? Container(
                                    height: 60,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5),
                                            width: 60,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Pallate.primaryColor),
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Icon(
                                              Icons.more_horiz,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: controller.order.value.status.last.title == 'pending'
                                              ? SlidingButton(
                                                  key: new GlobalKey(),
                                                  buttonHeight: 50,
                                                  buttonColor: Pallate.secondColor,
                                                  slideButtonIconColor: Colors.pink,
                                                  radius: 20,
                                                  buttonText: 'Trượt để xác nhận',
                                                  onSlideSuccessCallback: () {
                                                    controller.isLoading.value = true;

                                                    controller.confirmStatusOrder();
                                                  },
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    Get.toNamed('payment', arguments: {
                                                      'totalPrice': controller.order.value.totalPrice,
                                                      'orderId': controller.order.value.id,
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Pallate.primaryColor,
                                                    ),
                                                    margin: EdgeInsets.all(5),
                                                    height: 60,
                                                    child: Center(
                                                      child: Text(
                                                        'Thanh toán',
                                                        style: TextStyle(color: Colors.white, fontSize: 25),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        )
                      : CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppUltils.buildAppBar(
                  height: 50,
                  centerTitle: false,
                  title: "Đơn hàng",
                  actions: [],
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}
