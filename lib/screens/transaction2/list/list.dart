import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/transaction_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

class TransactionScreen2 extends GetView<TransactionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        // leading: Icon(Mdi.menu),
        height: 40,
        title: 'Giao dịch',

        actions: [
          InkWell(
            onTap: () {
              //Get.toNamed('customer/add');
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Mdi.export),
            ),
          ),
          InkWell(
            onTap: () {
              //Get.toNamed('customer/add');
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(FontAwesome.filter),
            ),
          ),
        ],
      ),
      drawer: DrawerApp(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Sản phẩm, khách hàng hoặc barcode',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.supervised_user_circle_outlined, color: Colors.black54),
                SizedBox(
                  width: 5,
                ),
                Text('Nhân viên'),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  FontAwesome.chevron_down,
                  size: 15,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: 5,
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hôm nay',
                          style: Palette.titleProduct(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '2 sale, 480.000 đ',
                          style: Palette.smallText(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RowTransactionItem(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: Get.height * .12,
            width: double.infinity,
            color: Colors.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tổng 30 ngày gần nhất',
                    style: Palette.textTitle1(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ' 2 đơn hàng: 480.000 đ',
                        style: Palette.textTitle2(),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowTransactionItem extends StatelessWidget {
  const RowTransactionItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(FontAwesome.money, size: 30),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                '480.000 đ',
                style: Palette.titleProduct(),
              ),
            ),
            Text('14:46'),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                '2x RedBull, 6x Cà phê',
                style: Palette.smallText(),
              ),
            ),
            Text('#1'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider()
      ],
    );
  }
}
