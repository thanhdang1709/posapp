import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_app/models/report_model.dart';
import 'package:pos_app/services/analytic_services.dart';

class AnalyticController extends GetxController with SingleGetTickerProviderMixin {
  final now = DateTime.now();
  TabController tabController;
  RxBool isLoading = true.obs;
  RxString startDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString endDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString typeFilter = 'today'.obs;
  RxList<ReportModel> reportLists = <ReportModel>[].obs;
  RxInt revenue = 0.obs;
  RxString bestDayRevenue = ''.obs;
  RxInt sales = 0.obs;
  RxString bestDaysales = ''.obs;
  RxList<Map> mapRevenueByDate = <Map>[].obs;
  RxList<Map> mapRevenueByDateTabHour = <Map>[].obs;
  RxList<Map> mapSaleByDate = <Map>[].obs;
  RxList<Map> mapRevenueByHour = <Map>[].obs;
  RxList<Map> mapRevenueByUser = <Map>[].obs;
  RxList<Map> mapSaleByHour = <Map>[].obs;
  RxInt avgSale = 0.obs;
  RxInt profit = 0.obs;
  RxString bestProduct = ''.obs;
  RxString bestUser = ''.obs;

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
      mapResponseToIndex();
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
      //group by date;
      // map doanh thu này để tính toán analytic screen
      mapRevenueByDate.assignAll(reportLists.map((v) {
        return {'totalPrice': v.totalPrice, 'createdAt': v.createdAt, 'sale': 1};
      }).toList());

      revenue.value = mapRevenueByDate.map((e) => e['totalPrice']).reduce((a, b) => a + b);
      dynamic maxRevenue = mapRevenueByDate.first;
      mapRevenueByDate.forEach((e) {
        if (e['totalPrice'] > maxRevenue['totalPrice']) maxRevenue = e;
      });
      bestDayRevenue.value = DateFormat('dd-MM-yyyy').format(maxRevenue['createdAt']);
      sales.value = mapRevenueByDate.length;

      //map by date dùng để show biểu đồ chi tiết theo ngày
      var groupMapRevenueByDate = groupBy(mapRevenueByDate, (obj) => DateFormat('yyyy-MM-dd').format(obj['createdAt']));
      mapSaleByDate.clear();
      groupMapRevenueByDate.forEach((k, v) {
        return mapSaleByDate.add({
          'sale': v.length,
          'createdAt': k,
          'revenue': v.map((e) => e['totalPrice']).reduce((a, b) => a + b),
        });
      });
      var max = 0;
      mapSaleByDate.forEach((v) {
        if (v['sale'] > max) {
          max = v['sale'];
          bestDaysales.value = DateFormat('dd-MM-yyyy').format(DateTime.parse(v['createdAt']));
        }
      });

      //best product
      var getListProduct = ((reportLists.map((v) {
        var result;
        v.products.forEach((product) {
          result = ({'product': product.name, 'productId': product.id});
        });
        return result;
      })));

      var groupListProduct = groupBy(getListProduct, (obj) => obj['productId']);
      var maxProduct = 0;
      groupListProduct
        ..forEach((k, v) {
          if (v.length > maxProduct) {
            maxProduct = v.length;
            bestProduct.value = v.first['product'];
          }
        });
      //group by hour
      mapRevenueByHour.assignAll(reportLists.map((v) {
        return {'totalPrice': v.totalPrice, 'createdAt': v.createdAt};
      }).toList());
      var groupRevenueByHour;
      if (inDays == 0 || inDays == -1) {
        groupRevenueByHour = groupBy(mapRevenueByHour, (obj) => DateFormat('yyyy-MM-dd HH').format(obj['createdAt']));
      } else {
        groupRevenueByHour = groupBy(mapRevenueByHour, (obj) => DateFormat('HH').format(obj['createdAt']));
      }

      mapRevenueByHour.clear();
      //var maxSale = 0;
      groupRevenueByHour.forEach((k, v) {
        mapRevenueByHour.add({'hour': k, 'revenue': v.map((e) => e['totalPrice']).reduce((a, b) => a + b), 'sale': v.length, 'max': false});
      });
      print(mapRevenueByHour);
      mapRevenueByHour.sort((a, b) => a['hour'].compareTo(b['hour']));

      //bestUser
      var groupRevenueByEmployee;
      groupRevenueByEmployee = groupBy(reportLists, (obj) => obj.user.id);
      mapRevenueByUser.clear();
      groupRevenueByEmployee.forEach((k, v) {
        mapRevenueByUser.add({
          'user_id': k,
          'user_name': reportLists.value.firstWhere((e) => e.user.id == k).user.name,
          'revenue': v.map((e) => e.totalPrice).reduce((a, b) => a + b),
          'sale': v.length,
          'max': false,
          'percent': ((v.length) / (sales.value ?? 1) * 100).toStringAsFixed(0)
        });
      });

      mapRevenueByUser.sort((a, b) => a['revenue'].compareTo(b['revenue']));
      mapRevenueByUser.assignAll(mapRevenueByUser.reversed.toList());
      bestUser.value = mapRevenueByUser.first['user_name'];
      print(mapRevenueByUser);
    } else {
      revenue.value = 0;
      bestDayRevenue.value = '';
      sales.value = 0;
      bestDaysales.value = '';
      mapRevenueByDate.clear();
      mapSaleByDate.clear();
      mapRevenueByHour.clear();
      mapSaleByHour.clear();
      mapRevenueByUser.clear();
    }
    // print(reportLists);
  }

  List<Widget> tabItem = [
    Tab(
      child: Text("Mỗi giờ"),
    ),
    Tab(
      child: Text("Mỗi ngày"),
    )
  ];
  int get inDays => (DateTime.parse(startDate.value).difference(DateTime.parse(endDate.value)).inDays);
  String get typeFilterLabel {
    switch (typeFilter.value) {
      case 'today':
        return 'Hôm nay (${DateFormat('dd-MM').format(DateTime.now())})';
        break;
      case 'this_week':
        return 'Tuần này ';
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
