import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/screens/receipt/components/row_action_receipt.dart';
import 'package:pos_app/ultils/number.dart';
import 'components/pdf.dart';

// ignore: must_be_immutable
class ReceiptScreen extends GetView {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoá đơn'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.close),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/img/logo.png',
                          height: 40,
                        ),
                        Text(
                          'Hoá Đơn #14',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Cà phê Panda',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '85 Nguyễn Huệ, Thành Phố Long Xuyên, AG',
                            maxLines: 2,
                            style: TextStyle(fontSize: 13),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '1 món (SL: 4)',
                            maxLines: 2,
                            style: Pallate.titleProduct(),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.blueGrey,
                    ),
                    Column(
                      children: [
                        RowItemReCeipt(
                          productName: 'Cà phê',
                          productPrice: 10000,
                          quantity: 4,
                        ),
                        Divider(),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Tổng: 40,000 đ',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Nhận: 50,000 đ',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Tiền thừa: 10,000 đ',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
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
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          now.day.toString() +
                              ' tháng ' +
                              now.month.toString() +
                              ' ' +
                              now.year.toString() +
                              ' ' +
                              now.hour.toString() +
                              ':' +
                              now.minute.toString(),
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          BottomActionReceipt(
            savePdf: savetoPdf,
          )
        ],
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
    return Row(
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
    );
  }
}
