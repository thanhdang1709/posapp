import 'package:flutter/material.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:intl/intl.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    Key key,
    this.listProducts,
    this.orderCode,
    this.orderPrice,
    this.time,
    this.buildItemName,
    this.icon,
    this.iconColor,
  }) : super(key: key);
  final int orderPrice;
  final DateTime time;
  final List listProducts;
  final String orderCode;
  final List<Widget> buildItemName;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 5),
            Text(
              '${$Number.numberFormat(orderPrice ?? 0)} đ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text('${DateFormat('Hm').format(time)}')
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [...buildItemName],
            ),
            Spacer(),
            Text('#$orderCode'),
          ],
        ),
        SizedBox(height: 5),
        Divider(),
      ],
    );
  }
}
