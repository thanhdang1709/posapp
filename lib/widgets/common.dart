import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/widgets/smart_refresher_success.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommonWidget {
  static progressIndicator() {
    Get.dialog(
        Center(
          child: SizedBox(height: 50, width: 50, child: CupertinoActivityIndicator()),
        ),
        barrierDismissible: false);
  }

  SmartRefresher smartRefresher({controller, Widget child}) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: SmartRefresherSuccess(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      child: child,
    );
  }
}
