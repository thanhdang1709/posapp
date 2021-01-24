import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_app/services/analytic_services.dart';

class AnalyticController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;

  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  RxString typeFilter = 'today'.obs;

  @override
  onInit() async {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    var results = await AnalyticServices().getReport(body: {"start_date": "2021-01-22", "end_date": "2021-01-23"});
    print(results);
  }

  List<Widget> tabHeader = [
    Tab(
      child: Text("Mỗi giờ"),
    ),
    Tab(
      child: Text("Mỗi ngày"),
    )
  ];

  String get typeFilterLabel {
    switch (typeFilter.value) {
      case 'today':
        return 'Hôm nay (${DateFormat('dd-MM').format(DateTime.now())})';
        break;
      case 'this_week':
        return 'Tuần này';
        break;
      case 'this_month':
        return 'Tháng này (tháng ${DateFormat('MM').format(DateTime.now())})';
        break;
      case 'this_year':
        return 'Năm nay  (${DateFormat('yyyy').format(DateTime.now())})';
        break;
      case 'yesterday':
        return 'Hôm qua  (${DateFormat('dd-MM').format(DateTime.now().subtract(Duration(days: 1)))})';
        break;
      case 'last_week':
        return 'Tuần trước';
        break;
      case 'last_month':
        return 'Tháng trước (tháng ${DateFormat('MM').format(DateTime.now().subtract(Duration(days: 30)))})';
        break;
      case 'last_year':
        return 'Năm trước  (${DateFormat('yyyy').format(DateTime.now().subtract(Duration(days: 365)))})';
        break;

      default:
        return '${DateFormat('dd/MM/yyyy').format(DateTime.parse(startDate.value))} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(endDate.value))}';
        break;
    }
  }
}
