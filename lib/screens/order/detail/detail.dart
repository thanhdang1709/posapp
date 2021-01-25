import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/order_detail_controller.dart';
import 'package:pos_app/models/status_model.dart';
import 'package:pos_app/models/status_model.dart';
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
                                                : RowStatus(controller: controller, lastStatus: controller.order.value.status)
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
                            Get.previousRoute == 'order' || Get.previousRoute == 'payment' || Get.previousRoute == 'order/detail'
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
                                                    controller.confirmStatusOrder(statusTitle: 'confirm', status: '2');
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

// ignore: must_be_immutable
class RowStatus extends StatelessWidget {
  RowStatus({Key key, this.lastStatus, this.controller}) : super(key: key);
  final List<StatusModel> lastStatus;
  final controller;

  List<Widget> buildRowStatus() {
    var list = statusList(lastStatus);
    if (lastStatus.last.title != 'pending') {
      list.removeAt(0);
    }

    return List.generate(
      list.length,
      (index) => InkWell(
        onTap: list[index]['onPressed'],
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: list[index]['active'] ? Border.all(color: Pallate.primaryColor) : Border.all(color: Colors.white),
          ),
          child: Row(
            children: [
              Icon(list[index]['icon'], color: list[index]['color']),
              SizedBox(
                width: 10,
              ),
              Text(
                list[index]['title'],
                style: TextStyle(color: list[index]['color']),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map> statusList(lastStatus) => [
        {
          'title': 'Chờ xác nhận',
          'icon': MdiIcons.clock,
          'color': Colors.black54,
          'onPressed': () {},
          'active': lastStatus.last.title == 'pending',
        },
        {
          'title': 'Xác nhận',
          'icon': MdiIcons.clock,
          'color': Colors.cyan,
          'onPressed': lastStatus.last.title != 'confirm'
              ? () {
                  controller.confirmStatusOrder(statusTitle: 'confirm', status: '2');
                  Get.back();
                }
              : null,
          'active': lastStatus.last.title == 'confirm',
        },
        {
          'title': 'Thanh toán',
          'icon': FontAwesome.dollar,
          'color': Colors.green,
          'onPressed': lastStatus.last.title != 'pending'
              ? () {
                  Get.toNamed('payment', arguments: {
                    'totalPrice': controller.order.value.totalPrice,
                    'orderId': controller.order.value.id,
                  });
                }
              : null,
          'active': lastStatus.last.title == 'payment',
        },
        {
          'title': 'Đang chế biến',
          'icon': MdiIcons.clock,
          'color': Colors.orangeAccent,
          'onPressed': lastStatus.last.title != 'cooking' && lastStatus.last.title != 'pending'
              ? () {
                  controller.confirmStatusOrder(statusTitle: 'cooking', status: '3');
                  Get.back();
                }
              : null,
          'active': lastStatus.last.title == 'cooking',
        },
        {
          'title': 'Đã chế biến',
          'icon': MdiIcons.database,
          'color': Colors.deepOrange,
          'onPressed': lastStatus.last.title != 'cooked' && lastStatus.last.title != 'pending'
              ? () {
                  controller.confirmStatusOrder(statusTitle: 'cooked', status: '4');
                  Get.back();
                }
              : null,
          'active': lastStatus.last.title == 'cooked',
        },
        {
          'title': 'Sẵn sàng',
          'icon': MdiIcons.checkAll,
          'color': Colors.greenAccent,
          'onPressed': lastStatus.last.title != 'ready' && lastStatus.last.title != 'pending'
              ? () {
                  controller.confirmStatusOrder(statusTitle: 'ready', status: '5');
                  Get.back();
                }
              : null,
          'active': lastStatus.last.title == 'ready',
        },
        {
          'title': 'Huỷ',
          'icon': MdiIcons.cancel,
          'color': Colors.red,
          'onPressed': lastStatus.last.title != 'cancel'
              ? () {
                  controller.cancelOrder();
                  Get.back();
                }
              : null,
          'active': lastStatus.last.title == 'cancel',
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.bottomSheet(
                  Container(
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Chọn trạng thái',
                                style: TextStyle(fontSize: 18),
                              ),

                              // Icon(Icons.close)
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                ...buildRowStatus()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                  isScrollControlled: false,
                  enableDrag: false);
            },
            child: Row(
              children: [
                Icon(
                  lastStatus.last.statusIcon,
                  color: lastStatus.last.statusColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(lastStatus.last.statusLabel ?? 'Chọn trạng thái', style: TextStyle(color: lastStatus.last.statusColor)),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  MdiIcons.chevronDown,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
