import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/data/controllers/transaction_controller.dart';
import 'package:pos_app/models/status_model.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

class TransactionScreen extends GetView<TransactionController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppUltils.buildAppBar(
          height: 50,
          centerTitle: false,
          title: 'Giao dịch',
          actions: [],
        ),
        drawer: DrawerApp(),
        body: Column(
          children: [
            // Container(
            //   color: Colors.grey[200],
            //   child: Padding(
            //     padding: const EdgeInsets.all(5),
            //     child: TextFormField(
            //       focusNode: FocusNode(),
            //       // controller: controller.searchKeyword,
            //       decoration: InputDecoration(
            //           prefixIcon: Icon(Icons.search, size: 35),
            //           border: InputBorder.none,
            //           hintText: 'Sản phẩm, khách hàng, giá, barcode'),
            //     ),
            //   ),
            // ),
            // RowFilterStatus(),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(
                      () => controller.mapOrders.length != 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...controller.buildOrderItem(controller.mapOrders),
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tổng 30 ngày gần nhất',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => Text(
                      '${$Number.numberFormat(controller.totalOrderPrice.value)}đ từ ${controller.totalOrderItem.value} đơn',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RowFilterStatus extends StatelessWidget {
  RowFilterStatus({
    Key key,
  }) : super(key: key);

  List<Widget> buildRowCheckbox() {
    return List.generate(
      status.length,
      (index) => Row(
        children: [
          Checkbox(
            value: status[index].isChecked ?? false,
            onChanged: (e) {},
          ),
          Text(status[index].title),
          Spacer(),
          Icon(
            MdiIcons.clock,
          )
        ],
      ),
    );
  }

  List<StatusModel> status = [
    new StatusModel(
      title: 'Chờ xác nhận',
      //icon: (Icons.close),
    ),
    new StatusModel(
      title: 'Đã xác nhận',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.bottomSheet(
                  Container(
                    padding: EdgeInsets.all(15),
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Chọn 1 hoặc nhiều...',
                                style: TextStyle(fontSize: 18),
                              ),
                              // Icon(Icons.close)
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [...buildRowCheckbox()],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                  isScrollControlled: false,
                  enableDrag: false);
            },
            child: Row(
              children: [
                Icon(
                  MdiIcons.clock,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Tất cả trạng thái'),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  MdiIcons.chevronDown,
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  FontAwesome.user,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Nhân viên'),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  MdiIcons.chevronDown,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
