import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/widgets/flexi_top_background.dart';

class AppUltils {
  static AppBar buildAppBar({
    String title,
    Widget leading,
    double height,
    List<Widget> actions,
    TabBar tabBar,
    bool centerTitle,
  }) {
    return AppBar(
      leading: leading ?? null,
      centerTitle: centerTitle ?? true,
      toolbarHeight: height ?? 40,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      flexibleSpace: FlexibleTopBackground(
        assetsImage: 'assets/img1.jpg',
      ),
      actions: actions,
      bottom: tabBar ?? null,
    );
  }

  getSnackBarSuccess({String title, String message}) {
    return Get.snackbar(
      'Thành công',
      message,
      duration: Duration(seconds: 3),
      colorText: Colors.white,
      backgroundGradient: LinearGradient(
        colors: [Colors.green, Colors.cyan],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  getSnackBarError({String title, String message}) {
    if (!Get.isSnackbarOpen)
      Get.snackbar(
        'Thất bại',
        message ?? 'Có lỗi xảy ra vui lòng thử lại',
        duration: Duration(seconds: 3),
        colorText: Colors.white,
        backgroundGradient: LinearGradient(
          colors: [Colors.red, Colors.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
  }
}
