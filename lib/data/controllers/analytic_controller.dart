import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_app/models/report_model.dart';
import 'package:pos_app/services/analytic_services.dart';

class AnalyticController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  RxBool isLoading = true.obs;
  RxString startDate = '2021-01-24'.obs;
  RxString endDate = '2021-01-26'.obs;
  RxString typeFilter = 'today'.obs;
  RxList<ReportModel> reportLists = <ReportModel>[].obs;
  RxInt revenue = 0.obs;
  RxString bestDayRevenue = ''.obs;
  RxInt sales = 0.obs;
  RxString bestDaysales = ''.obs;
  RxList<Map> mapRevenue = <Map>[].obs;
  RxList<Map> mapSale = <Map>[].obs;
  RxInt avgSale = 0.obs;
  RxInt profit = 0.obs;
  RxString bestProduct = ''.obs;
  @override
  onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    await getReport();
  }

  Future getReport() async {
    isLoading.value = true;
    // await Future.delayed(Duration(seconds: 2));
    var _results = await AnalyticServices().getReport(body: {"start_date": startDate.value, "end_date": endDate.value});
    if (_results.length == 0) {
      reportLists.clear();
      isLoading.value = false;
      return;
    }

    reportLists.assignAll(_results.map((e) => ReportModel.fromJson(e)).toList());
    mapResponseToIndex();
    isLoading.value = false;
  }

  mapResponseToIndex() {
    //tạo map doanh thu
    if (reportLists.length != 0) {
      mapRevenue.assignAll(reportLists.map((v) {
        return {'totalPrice': v.totalPrice, 'createdAt': v.createdAt, 'sale': 1};
      }).toList());
      revenue.value = mapRevenue.map((e) => e['totalPrice']).reduce((a, b) => a + b);
      dynamic maxRevenue = mapRevenue.first;
      mapRevenue.forEach((e) {
        if (e['totalPrice'] > maxRevenue['totalPrice']) maxRevenue = e;
      });
      bestDayRevenue.value = DateFormat('dd-MM-yyyy').format(maxRevenue['createdAt']);
      sales.value = mapRevenue.length;

      var groupMapRevenue = groupBy(mapRevenue, (obj) => DateFormat('yyyy-MM-dd').format(obj['createdAt']));
      groupMapRevenue.forEach((k, v) {
        return mapSale.add({'sale': v.length, 'createdAt': k});
      });
      var max = 0;
      mapSale.forEach((v) {
        if (v['sale'] > max) {
          max = v['sale'];
          bestDaysales.value = DateFormat('dd-MM-yyyy').format(DateTime.parse(v['createdAt']));
        }
      });

      var getListProduct = ((reportLists.map((v) {
        var result;
        v.products.forEach((product) {
          result = ({'product': product.name, 'productId': product.id});
        });
        return result;
      })));

      var groupListProduct = groupBy(getListProduct, (obj) => obj['productId']);
      print(groupListProduct);
      var maxProduct = 0;
      groupListProduct.forEach((k, v) {
        if (v.length > maxProduct) {
          maxProduct = v.length;
          bestProduct.value = v.first['product'];
        }
      });
      print(bestProduct.value);
    } else {
      revenue.value = 0;
      bestDayRevenue.value = '';
      sales.value = 0;
      bestDaysales.value = '';
      mapRevenue.clear();
      mapSale.clear();
    }
  }

  List<Widget> tabItem = [
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
