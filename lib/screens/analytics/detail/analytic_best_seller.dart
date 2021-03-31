import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/analytic_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/ultils/time.dart';

class AnalyticBestSellerScreen extends GetView<AnalyticController> {
  AnalyticBestSellerScreen({this.title, this.dateRange, this.total});
  final String title;
  final String dateRange;
  final String total;

  @override
  Widget build(BuildContext context) {
    // print(controller.mapRevenueByUser);
    List<GaugeSegment> _builData(mapRevenueByUser) {
      List<GaugeSegment> _lists = [];
      mapRevenueByUser.forEach((v) {
        _lists.add(
          new GaugeSegment(v['user_name'], double.parse(v['percent'])),
        );
      });
      return _lists;
    }

    final data = _builData(controller.mapRevenueByUser);
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
                  '${$Number.numberFormat(controller.sales.value)} / ${$Number.numberFormat(controller.revenue.value)} đ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Palette.primaryColor),
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
                          rows: controller.mapRevenueByUser
                              .map((e) => DataRow(cells: <DataCell>[
                                    DataCell(Text(e['user_name'].toString())),
                                    DataCell(Text($Number.numberFormat(e['revenue']))),
                                    DataCell(Text(e['sale'].toString())),
                                    DataCell(Text("${e['percent']}%")),
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
      "Nhân viên",
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
    DataColumn(
        label: Text(
      "Tỉ lệ",
      style: TextStyle(fontWeight: FontWeight.bold),
    )),
  ];
}

List<charts.Series<GaugeSegment, String>> _createSampleData(data) {
  return [
    new charts.Series<GaugeSegment, String>(
      id: 'Segments',
      domainFn: (GaugeSegment segment, _) => segment.segment,
      measureFn: (GaugeSegment segment, _) => segment.size,
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
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 60));
  }
}

/// Sample time series data type.
class GaugeSegment {
  final String segment;
  final double size;

  GaugeSegment(this.segment, this.size);
}
