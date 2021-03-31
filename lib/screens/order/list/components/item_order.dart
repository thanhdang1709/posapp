import 'package:flutter/material.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:intl/intl.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    Key key,
    this.buildItemName,
    this.order,
    this.orderPrice,
  }) : super(key: key);
  final int orderPrice;
  final List<Widget> buildItemName;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(order.status.last.statusIcon, color: order.status.last.statusColor),
            SizedBox(width: 5),
            Text(
              '${$Number.numberFormat(orderPrice ?? 0)} đ',
              style: Palette.textStyle().copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            order.paymentMethod != null
                ? Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Palette.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(order.paymentMethodLabel ?? '',
                        style: Palette.textStyle().copyWith(
                          color: Palette.colorTextOnPink,
                        )),
                  )
                : Container(),
            Spacer(),
            Text(
              '${DateFormat('Hm').format(order.createdAt)}',
              style: Palette.textStyle(),
            )
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              '${order.orderMethoLabel}',
              style: Palette.textStyle(),
            ),
            Spacer(),
            order.table != null
                ? Text(
                    'Bàn: ${order.table.name}',
                    style: Palette.textStyle(),
                  )
                : Container()
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
            Text(
              '#${order.orderCode}',
              style: Palette.textStyle(),
            ),
          ],
        ),
        SizedBox(height: 5),
        Divider(),
      ],
    );
  }
}
