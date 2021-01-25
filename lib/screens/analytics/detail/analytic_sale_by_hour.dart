import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/analytic_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/ultils/time.dart';

class AnalyticSaleByHourDetailScreen extends GetView<AnalyticController> {
  AnalyticSaleByHourDetailScreen({this.title, this.dateRange, this.total});
  final String title;
  final String dateRange;
  final String total;

  @override
  Widget build(BuildContext context) {
    print(controller.mapRevenueByHour);
    List<MyRow> _builData(mapRevenueByHour) {
      List<MyRow> _lists = [];
      mapRevenueByHour.forEach((v) {
        _lists.add(
          new MyRow((DateTime.parse(v['hour'])), v['sale']),
        );
      });
      return _lists;
    }

    final data = _builData(controller.mapRevenueByHour);
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
                  '${$Number.numberFormat(controller.sales.value)}',
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
              child: Row(
                children: [
                  Expanded(
                    child: CustomAxisTickFormatters(
                      _createSampleData(data),
                      animate: true,
                      isToday: true,
                    ),
                  ),
                ],
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
                          rows: controller.mapRevenueByHour
                              .map((e) => DataRow(cells: <DataCell>[
                                    DataCell(Text(e['hour'].toString().split(' ')[1] + 'h')),
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
    final simpleCurrencyFormatter = new charts.BasicNumericTickFormatterSpec.fromNumberFormat(NumberFormat.simpleCurrency(decimalDigits: 0, name: ''));
    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
        primaryMeasureAxis: isToday ? new charts.NumericAxisSpec(tickFormatterSpec: simpleCurrencyFormatter) : new charts.NumericAxisSpec(),
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
