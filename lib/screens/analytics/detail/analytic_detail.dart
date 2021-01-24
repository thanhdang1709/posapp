import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/analytic_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:pos_app/ultils/time.dart';

class AnalyticDetailScreen extends GetView<AnalyticController> {
  AnalyticDetailScreen({this.title, this.dateRange});
  final String title;
  final String dateRange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 40,
        centerTitle: false,
        title: title,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Tổng: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.blueGrey),
                ),
                Text(
                  '50.000.000 đ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Pallate.primaryColor),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  dateRange,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
                ),
              ],
            ),
            Container(
              height: Get.height * .4,
              child: CustomAxisTickFormatters(
                _createSampleData(),
                animate: true,
                isToday: true,
              ),
            ),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          columns: _buildHeaderTable(),
                          rows: map
                              .map((e) => DataRow(cells: <DataCell>[
                                    DataCell(Text(e.m.toString())),
                                    DataCell(Text(e.m.toString())),
                                    DataCell(Text(e.m.toString())),
                                  ]))
                              .toList()),
                    ),
                    Divider(),
                    Text('Hello'),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_buildHeaderTable() {
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

var map = {
  new MyMap(m: 1),
  new MyMap(m: 1),
  new MyMap(m: 1),
  new MyMap(m: 1),
  new MyMap(m: 1),
};

class MyMap {
  int m;

  MyMap({this.m});
}

List<charts.Series<MyRow, DateTime>> _createSampleData() {
  final data = [
    new MyRow(new DateTime.now(), 600000),
    new MyRow(new DateTime.now().add(Duration(hours: 1)), 300000),
    new MyRow(new DateTime.now().add(Duration(hours: 2)), 200000),
    new MyRow(new DateTime.now().add(Duration(hours: 3)), 100000),
    new MyRow(new DateTime.now().add(Duration(hours: 4)), 500000),
    new MyRow(new DateTime.now().add(Duration(days: 5)), 200000),
  ];

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
    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
        primaryMeasureAxis: new charts.NumericAxisSpec(tickFormatterSpec: simpleCurrencyFormatter),
        dateTimeFactory: LocalizedTimeFactory(Locale('vi', 'VN')),
        domainAxis: new charts.DateTimeAxisSpec(
          tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
            day: isToday ? new charts.TimeFormatterSpec(format: 'h', transitionFormat: 'HH:mm') : new charts.TimeFormatterSpec(format: 'd', transitionFormat: 'dd-MM'),
          ),
        ));
  }
}

/// Sample time series data type.
class MyRow {
  final DateTime timeStamp;
  final int cost;
  MyRow(this.timeStamp, this.cost);
}
