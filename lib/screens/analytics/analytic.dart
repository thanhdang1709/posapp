import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class AnalyticScreen extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 50,
        centerTitle: false,
        title: 'Thông kê',
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [],
      ),
    );
  }
}
