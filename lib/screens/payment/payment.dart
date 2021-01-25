import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/controllers/payment_controller.dart';
import 'package:pos_app/screens/payment/amount_received.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';

class PaymentScreen extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    var totalPrice = Get.arguments['totalPrice'];
    var orderId = Get.arguments['orderId'];
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 40,
        centerTitle: false,
        title: 'Thanh toán',
        actions: [
          Obx(() => controller.cartController.selectedCustomer.value.name != null
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.white,
                  )),
                  child: Text(controller.cartController.selectedCustomer.value.name, style: TextStyle(fontWeight: FontWeight.w700)),
                )
              : Text('')),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Get.toNamed('customer');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                FontAwesome.user_plus,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  //  '${$Number.numberFormat(cartController.totalPrice)} đ',
                  '${$Number.numberFormat(totalPrice)} đ',

                  style: TextStyle(fontSize: 40, color: Colors.cyan),
                ),
                SizedBox(height: 10),
                orderId == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: Get.height * 0.07,
                            width: Get.width * .8,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Pallate.primaryColor)),
                              //color: Colors.grey[300],
                              onPressed: () {
                                controller.saveOrder();
                              },
                              child: Text(
                                'Lưu hoá đơn',
                                style: Pallate.titleProduct(),
                              ),
                            ),
                          ),
                          // Container(
                          //   height: Get.height * 0.07,
                          //   width: Get.width * .4,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10)),
                          //   child: FlatButton(
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //         side: BorderSide(color: Pallate.primaryColor)),
                          //     //color: Colors.grey[300],
                          //     onPressed: () {},
                          //     child: Text(
                          //       'T.Toán sau',
                          //       style: Pallate.titleProduct(),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Pallate.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                      height: 10,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        print('payment');
                        Get.to(AmountNumpadWidget(
                          totalPrice: totalPrice,
                          orderId: orderId,
                          // totalPrice: cartController.totalPrice,
                          callbackSubmit: (e) {
                            print('$e');
                          },
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            'Tiếp tục',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Pallate.textTitle1(),
                          ),
                          Spacer(),
                          Icon(
                            FontAwesome.chevron_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
