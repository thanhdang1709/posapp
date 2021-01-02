import 'package:flutter/material.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:intl/intl.dart';

class ItemOrderGroupDate extends StatelessWidget {
  const ItemOrderGroupDate({
    Key key,
    this.totalPrice = 0,
    this.totalQuantity = 0,
    this.createdAt,
    this.buildListItemOrder,
  }) : super(key: key);
  final DateTime createdAt;
  final int totalQuantity;
  final int totalPrice;
  final List<Widget> buildListItemOrder;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${DateFormat.EEEE('vi').format(createdAt)} ${DateFormat('dd-MM').format(createdAt)}',
                  style: Pallate.titleProduct(),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '$totalQuantity đơn ${$Number.numberFormat(totalPrice)} đ',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [...buildListItemOrder],
        ),
        SizedBox(
          height: 30,
        ),
        Divider(
          thickness: 2,
          color: Colors.pink,
        ),
      ],
    );
  }

  // Widget itemOrder(orderPrice, time, listProduct, orderCode) {
  //   return ItemOrder();
  // }
}
