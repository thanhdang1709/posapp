import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonWidget {
  static progressIndicator() {
    Get.dialog(
        Center(
          child: SizedBox(
              height: 50, width: 50, child: CircularProgressIndicator()),
        ),
        barrierDismissible: false);
  }
}
