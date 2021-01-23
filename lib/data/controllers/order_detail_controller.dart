import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/status_model.dart';
import 'package:pos_app/screens/order/components/timeline.dart';
import 'package:pos_app/services/order_service.dart';
import 'package:pos_app/ultils/number.dart';

import 'package:intl/intl.dart';

class OrderDetailController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  Rx<OrderModel> order = OrderModel().obs;
  RxBool isLoading = true.obs;
  int orderId = 0;
  @override
  void onInit() async {
    super.onInit();
    orderId = Get.arguments.id;
    tabController = TabController(length: 2, vsync: this);
    await getOrderById(orderId);
    isLoading.value = false;
  }

  updateStatusOrder() {}
  confirmStatusOrder() async {
    Map<String, String> data = {
      'order_id': order.value.id.toString(),
      'status_title': 'confirm',
      'status': 2.toString(),
    };
    var _result = await OrderService().updatePayment(data: data);
    print(_result);
    await getOrderById(orderId);
    isLoading.value = false;
  }

  Future<OrderModel> getOrderById(id) async {
    var result = await OrderService().getOrder(id);
    order.value = OrderModel.fromJson(result);
    return OrderModel.fromJson(result);
  }

  List<Widget> buildItemName(List<ProductModel> products) {
    List<Widget> lists = [];
    var groupProductById = groupBy(products, (obj) => obj.id);
    groupProductById.forEach((k, v) {
      lists
        ..add(Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${v.length} x ${v.first.name} (${$Number.numberFormat(v.first.price)})',
              ),
              Text(
                '${$Number.numberFormat(v.length * v.first.price)} đ',
              ),
            ],
          ),
        ));
    });
    return lists;
  }

  List<Widget> buildTimeLineStatus(List<StatusModel> status, OrderModel order) {
    List<Widget> results = [];
    status = status.reversed.toList();
    List.generate(
        status.length,
        (index) => {
              results.add(TimeLineStatus(
                iconData: status[index].statusIcon,
                iconColor: status[index].statusColor,
                isFirst: index == 0 ? true : false,
                isLast: false,
                hour: '',
                title: status[index].title,
                content: DateFormat('dd/MM/yyyy - hh:mm').format(DateTime.parse(status[index].createdAt).toLocal()),
              ))
            });
    results.add(TimeLineStatus(
      iconData: FontAwesome.money,
      iconColor: Colors.green,
      isLast: true,
      hour: '',
      title: 'Tổng:',
      content: $Number.numberFormat(order.totalPrice) + ' đ',
    ));
    return results;
  }

  List<Widget> tabItem = [
    Tab(
      child: Text("Món"),
    ),
    Tab(
      child: Text("Chi tiết"),
    )
  ];
}
