import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({Key key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        // leading: Icon(Mdi.menu),
        height: 40,
        title: 'Thanh toán',
        actions: [
          // InkWell(
          //   onTap: () {
          //     Get.toNamed('customer/add');
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: Icon(Icons.add),
          //   ),
          // )
        ],
      ),
    );
  }
}
