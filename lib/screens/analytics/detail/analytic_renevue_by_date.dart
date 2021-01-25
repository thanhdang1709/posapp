import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/analytic_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/ultils/time.dart';
import 'package:pos_app/widgets/tab_view/tab_heading.dart';

class AnalyticRenevueByDateDetailScreen extends GetView<AnalyticController> {
  AnalyticRenevueByDateDetailScreen({this.title, this.dateRange});
  final String title;
  final String dateRange;

  @override
  Widget build(BuildContext context) {
    print(controller.mapRevenueByHour);
    final now = DateTime.now();
    List<MyRow> _builDataTab1(mapRevenueByHour) {
      List<MyRow> _lists = [];
      mapRevenueByHour.forEach((v) {
        _lists.add(
          new MyRow((DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.value)) + ' ' + v['hour'])), v['revenue']),
        );
      });
      return _lists;
    }

    final data1 = _builDataTab1(controller.mapRevenueByHour);

    List<MyRow> _builDataTab2(mapSaleByDate) {
      List<MyRow> _lists = [];
      mapSaleByDate.forEach((v) {
        _lists.add(
          new MyRow((DateTime.parse(v['createdAt'])), v['revenue']),
        );
      });
      return _lists;
    }

    final data2 = _builDataTab2(controller.mapSaleByDate);

    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 40,
        centerTitle: false,
        title: title,
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  'Tổng: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.blueGrey),
                ),
                Text(
                  '${$Number.numberFormat(controller.revenue.value)} đ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Pallate.primaryColor),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 5, left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  dateRange,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
                ),
              ],
            ),
          ),
          TabHeading(
            controller: controller,
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: Get.height * .4,
                        child: CustomAxisTickFormatters(
                          _createSampleData(data1),
                          animate: true,
                        ),
                      ),
                      Divider(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: _buildHeaderTableTab1(),
                            rows: controller.mapRevenueByHour
                                .map((e) => DataRow(cells: <DataCell>[
                                      DataCell(Text("${e['hour']}h")),
                                      DataCell(Text($Number.numberFormat(e['revenue']))),
                                      DataCell(Text(e['sale'].toString())),
                                    ]))
                                .toList()),
                      ),
                      Divider(),
                      // Text('Hello'),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: Get.height * .4,
                        child: CustomAxisTickFormatters(
                          _createSampleData(data2),
                          animate: true,
                        ),
                      ),
                      Divider(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: _buildHeaderTableTab2(),
                            rows: controller.mapSaleByDate
                                .map((e) => DataRow(cells: <DataCell>[
                                      DataCell(Text(e['createdAt'].toString())),
                                      DataCell(Text($Number.numberFormat(e['revenue']))),
                                      DataCell(Text(e['sale'].toString())),
                                    ]))
                                .toList()),
                      ),
                      Divider(),
                      // Text('Hello'),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

_buildHeaderTableTab1() {
  return [
    DataColumn(
        label: Text(
      "Giờ",
      style: TextStyle(fontWeight: FontWeight.bold),
    )),
    DataColumn(
        label: Text(
      "Doanh thu",
      style: TextStyle(fontWeight: FontWeight.bold),
    )),
    DataColumn(
        label: Text(
      "Đơn hàng",
      style: TextStyle(fontWeight: FontWeight.bold),
    )),
  ];
}

_buildHeaderTableTab2() {
  return [
    DataColumn(
        label: Text(
      "Ngày",
      style: TextStyle(fontWeight: FontWeight.bold),
    )),
    DataColumn(
        label: Text(
      "Doanh thu",
      style: TextStyle(fontWeight: FontWeight.bold),
    )),
    DataColumn(
        label: Text(
      "Đơn hàng",
      style: TextStyle(fontWeight: FontWeight.bold),
    )),
  ];
}

List<charts.Series<MyRow, DateTime>> _createSampleData(data) {
  return [
    new charts.Series<MyRow, DateTime>(
      id: 'Cost',
      domainFn: (MyRow row, _) => row.timeStamp,
      measureFn: (MyRow row, _) => row.cost,
      data: data,
    )
  ];
}

class CustomAxisTickFormatters extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final bool isToday;

  CustomAxisTickFormatters(
    this.seriesList, {
    this.animate,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    final simpleCurrencyFormatter = new charts.BasicNumericTickFormatterSpec.fromNumberFormat(new NumberFormat.compactSimpleCurrency(locale: Locale('vi', 'VN').languageCode));
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      primaryMeasureAxis: new charts.NumericAxisSpec(tickFormatterSpec: simpleCurrencyFormatter),
      dateTimeFactory: LocalizedTimeFactory(Locale('vi', 'VN')),
      domainAxis: new charts.DateTimeAxisSpec(
        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
          day: isToday ? new charts.TimeFormatterSpec(format: 'h', transitionFormat: 'HH:mm') : new charts.TimeFormatterSpec(format: 'd', transitionFormat: 'dd-MM'),
        ),
      ),
    );
  }
}

/// Sample time series data type.
class MyRow {
  final DateTime timeStamp;
  final int cost;
  MyRow(this.timeStamp, this.cost);
}
