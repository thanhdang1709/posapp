import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
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
        style: Palette.textStyle().copyWith(color: Colors.white, fontSize: 20),
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

  getSnackBarWarning({String title, String message}) {
    if (!Get.isSnackbarOpen)
      Get.snackbar(
        'Chạm 2 lần để thoát',
        message ?? 'Có lỗi xảy ra vui lòng thử lại',
        duration: Duration(seconds: 3),
        colorText: Colors.white,
        backgroundGradient: LinearGradient(
          colors: [Colors.grey, Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    // Get.dialog(Container(
    //   child: Center(
    //     child: Text('Chạm 2 lần để thoát'),
    //   ),
    // ));
  }

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (this.currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      getSnackBarWarning(message: "", title: "Cảnh báo thoát ứng dụng");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
