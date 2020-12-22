import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/common/vertical_divider.dart';

class RowTotalPrice extends StatelessWidget {
  const RowTotalPrice({
    Key key,
    this.totalPrice,
  }) : super(key: key);
  final int totalPrice;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Text(
                    'Mã giảm giá?',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Row(
                children: [
                  Text(
                    'TỔNG:',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${$Number.numberFormat(totalPrice)} đ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key key,
    this.quality,
    this.productName,
    this.totalPriceItem,
    this.isExtend = false,
  }) : super(key: key);

  final int quality;
  final String productName;
  final int totalPriceItem;
  final bool isExtend;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$quality X',
                style: Pallate.titleProduct(),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '$productName',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Pallate.titleProduct(),
              ),
              Spacer(),
              Text(
                '${$Number.numberFormat(totalPriceItem)} đ',
                style: Pallate.titleProduct(),
              ),
            ],
          ),
          if (isExtend)
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.kitchen,
                          ),
                          Text(
                            '1',
                          ),
                        ],
                      ),
                      $VerticalDivider(),
                      Column(
                        children: [
                          Icon(
                            FontAwesome.dollar,
                          ),
                          Text(
                            '80.000 đ',
                          ),
                        ],
                      ),
                      $VerticalDivider(),
                      Column(
                        children: [
                          Icon(
                            FontAwesome.dollar,
                            color: Colors.red,
                          ),
                          Text(
                            'Discount',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
