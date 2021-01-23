import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/order_detail_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:intl/intl.dart';
import 'package:pos_app/ultils/number.dart';

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
                                                : Text(controller.order.value.status.first.title)
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Text(
                                              '#' + controller.order.value.orderCode,
                                              style: TextStyle(color: Colors.blue),
                                            ),
                                            Text('Nhân viên')
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
                                    child: TabBarView(
                                      controller: controller.tabController,
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [...controller.buildItemName(controller.order.value.products)],
                                          ),
                                        ),
                                        Column(children: [...controller.buildTimeLineStatus(controller.order.value.status, controller.order.value)]),
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
                                            width: 60,
                                            height: 50,
                                            color: Colors.white,
                                            child: Icon(
                                              Icons.more_horiz,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
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

class TabHeading extends StatelessWidget {
  const TabHeading({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final OrderDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Pallate.secondColor.withOpacity(0.7),
            Pallate.primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TabBar(
        unselectedLabelColor: Colors.white,
        labelColor: Colors.pink,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 4,
              color: Colors.pink,
            ),
            insets: EdgeInsets.only(left: 0, right: 8, bottom: 0)),
        tabs: controller.tabItem,
        controller: controller.tabController,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
    );
  }
}
