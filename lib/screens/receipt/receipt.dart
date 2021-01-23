import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/controllers/receipt_controller.dart';
import 'package:pos_app/screens/receipt/components/row_action_receipt.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:tiengviet/tiengviet.dart';

// ignore: must_be_immutable
class ReceiptScreen extends GetView<ReceiptController> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Hoá đơn'),
      ),
      body: Obx(
        () => controller.order.length != 0
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  cartController.productStore.cartItem.clear();
                                  Get.offNamed('pos');
                                },
                                child: Icon(Icons.close)),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/img/logo-1.png',
                                  height: 40,
                                ),
                                Obx(() => Text(
                                      'Hoá Đơn #${controller.order?.first?.orderCode}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  TiengViet.parse(GetStorage().read('store_name') ?? 'Ca Phe Vinatech'),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '154 Pham Van Chieu - P.9 - Q.Go Vap - HCM',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Obx(() => Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${controller.totalMenu} món (SL: ${controller.totalOrderItem})',
                                        maxLines: 2,
                                        style: Pallate.titleProduct(),
                                      ),
                                    )
                                  ],
                                )),
                            Divider(
                              thickness: 2,
                              color: Colors.blueGrey,
                            ),
                            Obx(() => Column(
                                  children: [...controller.buildRowItem()],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => controller.order.first.note != null
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Ghi chú: ${controller.order.first.note ?? ''}",
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(
                                  () => Text(
                                    'Tổng: ${$Number.numberFormat(controller.order?.first?.totalPrice ?? 0)} đ',
                                    style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Obx(
                                  () => controller.order?.first?.amountReceive != 0
                                      ? Text(
                                          'Nhận: ${$Number.numberFormat(controller.order?.first?.amountReceive)} đ',
                                          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                                        )
                                      : Text(''),
                                )
                              ],
                            ),
                            Obx(
                              () => controller.order?.first?.change != 0
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Tiền thừa: ${$Number.numberFormat(controller.order?.first?.change)} đ',
                                          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    )
                                  : Text(''),
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.blueGrey,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Cảm ơn quý khách, hẹn gặp lại!',
                                  style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 15),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  // ignore: null_aware_before_operator
                                  controller.order?.first?.createdAt?.day?.toString() +
                                      ' tháng ' +
                                      controller.order?.first?.createdAt?.month?.toString() +
                                      ' ' +
                                      controller.order?.first?.createdAt?.year?.toString() +
                                      ' ' +
                                      controller.order?.first?.createdAt?.hour?.toString() +
                                      ':' +
                                      controller.order?.first?.createdAt?.minute?.toString(),
                                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BottomActionReceipt(),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class RowItemReCeipt extends StatelessWidget {
  const RowItemReCeipt({
    Key key,
    this.quantity,
    this.productName,
    this.productPrice,
  }) : super(key: key);
  final int quantity;
  final String productName;
  final int productPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$quantity x'),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Text(
                      productName,
                      style: Pallate.titleProduct(),
                    ),
                    Text(
                      '${$Number.numberFormat(productPrice)} đ',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            Text('${$Number.numberFormat(quantity * productPrice)} đ')
          ],
        ),
        Divider(),
      ],
    );
  }
}
