import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/controllers/payment_controller.dart';
import 'package:pos_app/screens/receipt/receipt.dart';
import 'package:pos_app/ultils/number.dart';

class PaymentDoneScreen extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    var agrs = Get.arguments;
    agrs = agrs ?? {'totalPrice': 0, 'amountReceive': 0};
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(
                    Icons.check,
                    size: 200,
                    color: Colors.green,
                  ),
                  Text('Thành công', style: TextStyle(fontSize: 30)),
                  SizedBox(
                    height: 10,
                  ),
                  agrs != null
                      ? Text(
                          agrs != null
                              ? 'Đơn hàng: ' +
                                  $Number.numberFormat(agrs['totalPrice']) +
                                  ' đ'
                              : '',
                          style: TextStyle(
                              fontSize: 20, color: Pallate.primaryColor),
                        )
                      : Text(''),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Đã nhận: ' +
                        $Number.numberFormat(agrs['amountReceive']) +
                        ' đ',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tiền thừa: ' +
                        $Number.numberFormat(
                            agrs['amountReceive'] - agrs['totalPrice']) +
                        ' đ',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long,
                  color: Colors.grey,
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.offAll(ReceiptScreen());
                  },
                  child: Text(
                    'Xem hoá đơn',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    cartController.productStore.cartItem.clear();
                    Get.offAllNamed('pos');
                  },
                  child: Text(
                    'Tạo đơn mới',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Pallate.textTitle1(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}