import 'package:flutter/material.dart';
import 'package:pos_app/widgets/flexi_top_background.dart';

class AppUltils {
  static AppBar buildAppBar(
      {String title,
      Widget leading,
      double height,
      List<Widget> actions,
      TabBar tabBar}) {
    return AppBar(
      leading: leading ?? null,
      centerTitle: true,
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
}
