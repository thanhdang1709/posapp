import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/analytic_controller.dart';
import 'package:pos_app/screens/analytics/components/filter.dart';
import 'package:pos_app/screens/analytics/detail/analytic_best_seller.dart';
import 'package:pos_app/screens/analytics/detail/analytic_renevue_by_date.dart';
import 'package:pos_app/screens/analytics/detail/analytic_renevue_by_hour.dart';
import 'package:pos_app/screens/analytics/detail/analytic_sale_by_hour.dart';
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
        title: 'report.report'.tr,
        actions: [],
      ),
      drawer: DrawerApp(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(
          () => !controller.isLoading.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => FilterDateContainer(
                          label: controller.typeFilterLabel ?? 'time.today'.tr,
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
                          label: 'report.revenue'.tr,
                          amount: controller.revenue.value,
                          bestDay: controller.bestDayRevenue.value,
                          onPressed: () {
                            if (controller.inDays == 0 || controller.inDays == -1) {
                              Get.to(AnalyticRenevueByHourDetailScreen(
                                title: 'report.revenue'.tr,
                                dateRange: controller.typeFilterLabel,
                              ));
                            } else {
                              Get.to(AnalyticRenevueByDateDetailScreen(
                                title: 'label.revenue'.tr,
                                dateRange: controller.typeFilterLabel,
                              ));
                            }
                          },
                        ),
                        AnalyticItem(
                          label: 'label.order'.tr,
                          amount: controller.sales.value,
                          isNumber: true,
                          bestDay: controller.bestDaysales.value,
                          onPressed: () {
                            if (controller.inDays == 0 || controller.inDays == -1) {
                              Get.to(AnalyticSaleByHourDetailScreen(
                                title: 'report.total_order'.tr,
                                dateRange: controller.typeFilterLabel,
                              ));
                            } else {
                              Get.to(AnalyticRenevueByDateDetailScreen(
                                title: 'report.total_order'.tr,
                                dateRange: controller.typeFilterLabel,
                              ));
                            }
                          },
                        ),
                        AnalyticItem(
                          label: 'report.avg_one_order'.tr,
                          amount: controller.avgSale.value,
                          bestDay: controller.bestDaysales.value,
                          onPressed: () {},
                        ),
                        AnalyticItem(
                          label: 'report.profit'.tr,
                          amount: controller.profit.value,
                          bestDay: '',
                          onPressed: () {},
                        ),
                        AnalyticItem(
                          label: 'report.best_sale_product'.tr,
                          title: controller.bestProduct.value,
                          bestAmount: 0,
                          onPressed: () {},
                        ),
                        AnalyticItem(
                          label: 'label.employee'.tr,
                          title: controller.bestUser.value ?? '',
                          bestAmount: controller.mapRevenueByUser.length != 0 ? controller.mapRevenueByUser?.last['revenue'] : 0,
                          onPressed: () {
                            Get.to(AnalyticBestSellerScreen(
                              title: 'label.employee'.tr,
                              dateRange: controller.typeFilterLabel,
                            ));
                          },
                        ),
                        AnalyticItem(
                          label: 'label.customer'.tr,
                          title: '',
                          bestAmount: 0,
                          onPressed: () {},
                        ),
                      ],
                    )))
                  ],
                )
              : Center(child: CircularProgressIndicator()),
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
  final String bestDay;
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
              style: Palette.titleProduct(),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              amount != null ? '${$Number.numberFormat(amount)} ${isNumber ? '' : 'đ'}' : title,
              style: TextStyle(
                color: Palette.primaryColor,
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
                    ? Text('${'report.best_day'.tr}: $bestDay', style: TextStyle(color: Palette.colorCyan, fontWeight: FontWeight.w500))
                    : Text('${'report.sales'.tr}' + ': ${$Number.numberFormat(bestAmount ?? 0)} đ', style: TextStyle(color: Palette.colorCyan, fontWeight: FontWeight.w500)),
                //: Text(''),
                Icon(
                  MdiIcons.chevronRight,
                  color: Palette.colorCyan,
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Palette.primaryColor.withOpacity(.5), width: 2)),
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
