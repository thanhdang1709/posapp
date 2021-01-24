import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/analytic_controller.dart';
import 'package:pos_app/screens/analytics/components/filter.dart';
import 'package:pos_app/screens/analytics/detail/analytic_detail.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

class AnalyticScreen extends GetView<AnalyticController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 50,
        centerTitle: false,
        title: 'Thống kê',
        actions: [],
      ),
      drawer: DrawerApp(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => FilterDateContainer(
                  label: controller.typeFilterLabel ?? 'Hôm nay',
                )),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnalyticItem(
                  label: 'Doanh thu',
                  amount: 400000,
                  bestDay: DateTime.now(),
                  onPressed: () {
                    Get.to(AnalyticDetailScreen(
                      title: 'Doanh thu',
                      dateRange: controller.typeFilterLabel,
                    ));
                  },
                ),
                AnalyticItem(
                  label: 'Đơn',
                  amount: 40,
                  isNumber: true,
                  bestDay: DateTime.now(),
                  onPressed: () {},
                ),
                AnalyticItem(
                  label: 'Trung bình 1 đơn',
                  amount: 400000,
                  bestDay: DateTime.now(),
                  onPressed: () {},
                ),
                AnalyticItem(
                  label: 'Lợi nhuận',
                  amount: 400000,
                  bestDay: DateTime.now(),
                  onPressed: () {},
                ),
                AnalyticItem(
                  label: 'Sản phẩm bán tốt nhất',
                  title: 'Bún bò',
                  bestAmount: 30000,
                  onPressed: () {},
                ),
                AnalyticItem(
                  label: 'Nhân viên ',
                  title: 'Cao Thanh Đẳng',
                  bestAmount: 40000000,
                  onPressed: () {},
                ),
                AnalyticItem(
                  label: 'Khách hàng',
                  title: '',
                  bestAmount: 30000,
                  onPressed: () {},
                ),
              ],
            )))
          ],
        ),
      ),
    );
  }
}

class AnalyticItem extends StatelessWidget {
  const AnalyticItem({
    Key key,
    this.label,
    this.amount,
    this.bestDay,
    this.onPressed,
    this.isNumber = false,
    this.bestAmount,
    this.title,
  }) : super(key: key);
  final String label;
  final int amount;
  final String title;
  final DateTime bestDay;
  final Function onPressed;
  final bool isNumber;
  final int bestAmount;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Pallate.titleProduct(),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              amount != null ? '${$Number.numberFormat(amount)} ${isNumber ? '' : 'đ'}' : title,
              style: TextStyle(
                color: Pallate.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bestDay != null
                    ? Text('Ngày cao nhất: ${bestDay.day} tháng ${bestDay.month}', style: TextStyle(color: Pallate.colorCyan, fontWeight: FontWeight.w500))
                    : Text('Đơn cao nhất: ${$Number.numberFormat(bestAmount)} đ', style: TextStyle(color: Pallate.colorCyan, fontWeight: FontWeight.w500)),
                Icon(
                  MdiIcons.chevronRight,
                  color: Pallate.colorCyan,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}

class FilterDateContainer extends StatelessWidget {
  const FilterDateContainer({
    Key key,
    this.label,
  }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(FilterAnalytic(), fullscreenDialog: true);
      },
      child: Container(
        height: Get.height * .08,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallate.primaryColor.withOpacity(.5), width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   MdiIcons.chevronLeft,
            //   size: 25,
            // ),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            // Icon(
            //   MdiIcons.chevronRight,
            //   size: 25,
            // ),
          ],
        ),
      ),
    );
  }
}
