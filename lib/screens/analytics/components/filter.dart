import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/analytic_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

class FilterAnalytic extends GetView<AnalyticController> {
  @override
  Widget build(BuildContext context) {
    AnalyticController controller = Get.find();
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 50,
        centerTitle: false,
        title: 'Chọn thời gian',
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                    child: Obx(() => InkWell(
                          onTap: () async {
                            List<DateTime> picked = await DateRagePicker.showDatePicker(
                              context: context,
                              initialFirstDate: controller.startDate.value == '' ? new DateTime.now() : DateTime.parse(controller.startDate.value),
                              initialLastDate: controller.endDate.value == '' ? new DateTime.now() : DateTime.parse(controller.endDate.value),
                              firstDate: new DateTime(2021),
                              lastDate: new DateTime(2022),
                            );
                            if (picked != null) {
                              controller.startDate.value = picked.first.toString();
                              controller.endDate.value = picked.last.toString();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: Pallate.primaryColor), borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(MdiIcons.calendarRange, size: 30, color: Colors.blueGrey),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Chọn thời gian ${controller.startDate.value != '' ? '' : ''}',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => controller.startDate.value != ''
                            ? Text(
                                'Bắt đầu: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.startDate.value))}',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                              )
                            : Container())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => controller.endDate.value != ''
                            ? Text(
                                'Kết thúc: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.endDate.value))}',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                              )
                            : Container())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            TypeTimeContainer(
                              label: 'Hôm nay',
                              onPressed: () {
                                controller.typeFilter.value = 'today';
                                controller.startDate.value = '';
                                controller.endDate.value = '';
                                Get.back();
                              },
                              active: controller.typeFilter.value == 'today',
                            ),
                            TypeTimeContainer(
                              label: 'Tuần này',
                              onPressed: () {
                                controller.typeFilter.value = 'this_week';
                                controller.startDate.value = '';
                                controller.endDate.value = '';
                                Get.back();
                              },
                              active: controller.typeFilter.value == 'this_week',
                            ),
                            TypeTimeContainer(
                              label: 'Tháng này',
                              onPressed: () {
                                controller.typeFilter.value = 'this_month';
                                controller.startDate.value = '';
                                controller.endDate.value = '';
                                Get.back();
                              },
                              active: controller.typeFilter.value == 'this_month',
                            ),
                            TypeTimeContainer(
                              label: 'Năm này',
                              onPressed: () {
                                controller.typeFilter.value = 'this_year';
                                controller.startDate.value = '';
                                controller.endDate.value = '';
                                Get.back();
                              },
                              active: controller.typeFilter.value == 'this_year',
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            TypeTimeContainer(
                              label: 'Hôm qua',
                              onPressed: () {
                                controller.typeFilter.value = 'yesterday';
                                controller.startDate.value = '';
                                controller.endDate.value = '';
                                Get.back();
                              },
                              active: controller.typeFilter.value == 'yesterday',
                            ),
                            TypeTimeContainer(
                              label: 'Tuần trước',
                              onPressed: () {
                                controller.typeFilter.value = 'last_week';
                                controller.startDate.value = '';
                                controller.endDate.value = '';
                                Get.back();
                              },
                              active: controller.typeFilter.value == 'last_week',
                            ),
                            TypeTimeContainer(
                              label: 'Tháng trước',
                              onPressed: () {
                                controller.typeFilter.value = 'last_month';
                                controller.startDate.value = '';
                                controller.endDate.value = '';
                                Get.back();
                              },
                              active: controller.typeFilter.value == 'last_month',
                            ),
                            TypeTimeContainer(
                              label: 'Năm trước',
                              onPressed: () {
                                controller.typeFilter.value = 'last_year';
                                controller.startDate.value = '';
                                controller.endDate.value = '';
                                Get.back();
                              },
                              active: controller.typeFilter.value == 'last_year',
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.typeFilter.value = '';
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Pallate.primaryColor,
              ),
              margin: EdgeInsets.all(5),
              height: 50,
              child: Center(
                child: Text(
                  'Áp dụng',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TypeTimeContainer extends StatelessWidget {
  const TypeTimeContainer({
    Key key,
    this.label,
    this.onPressed,
    this.active = false,
  }) : super(key: key);
  final String label;
  final Function onPressed;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(border: Border.all(color: active ? Pallate.primaryColor : Colors.grey.withOpacity(.5))),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
