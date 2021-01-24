import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/analytic_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/ultils/time.dart';

class AnalyticDetailScreen extends GetView<AnalyticController> {
  AnalyticDetailScreen({this.title, this.dateRange});
  final String title;
  final String dateRange;

  @override
  Widget build(BuildContext context) {
    print(controller.mapSale);
    List<MyRow> _builData(mapSale) {
      List<MyRow> _lists = [];
      mapSale.forEach((v) {
        _lists.add(
          new MyRow((DateTime.parse(v['createdAt'])), v['sale']),
        );
      });
      return _lists;
    }

    final data = _builData(controller.mapSale);
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
                  '${$Number.numberFormat(controller.revenue.value)} đ',
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
                _createSampleData(data),
                animate: true,
                isToday: false,
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
                          rows: controller.mapSale
                              .map((e) => DataRow(cells: <DataCell>[
                                    DataCell(Text(e['createdAt'].toString())),
                                    DataCell(Text(e['sale'].toString())),
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
