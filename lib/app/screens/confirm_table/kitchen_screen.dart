import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/app/controllers/confirm_table_controller.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';
import 'package:pos_app/widgets/flexi_top_background.dart';

import 'components/table_list.dart';

class ConfirmTableScreen extends StatefulWidget {
  const ConfirmTableScreen({Key key}) : super(key: key);

  @override
  _PosScreenState createState() => _PosScreenState();
}

class _PosScreenState extends State<ConfirmTableScreen> with SingleTickerProviderStateMixin {
  TabController _controller;
  // ignore: unused_field
  int _selectedIndex = 0;
  //get catelo
  List<Widget> lists = [
    Tab(
      icon: Text('Xác nhân bàn'.tr),
    ),
    // Tab(
    //   icon: Text('label.await_confirm'.tr),
    // ),
    // Tab(
    //   icon: Text('label.cooking'.tr),
    // ),
    // Tab(
    //   icon: Text('label.ready'.tr),
    // )
  ];

  var box = GetStorage();

  ConfirmTableController kitchenController = Get.find<ConfirmTableController>();
  @override
  void initState() {
    _controller = TabController(length: lists.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildItemPost() {
      List<Widget> buildItem = [];
      // posStore.areaList.forEach(
      //   (e) => buildItem
      //     ..add(
      //       KitchenList(
      //         statusId: e.id,
      //       ),
      //     ),
      // );
      lists.forEach((e) {
        buildItem
          ..add(
            TableList(
              statusId: 0,
            ),
          );
      });
      return buildItem;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Text(
          'label.table'.tr,
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: FlexibleTopBackground(
          assetsImage: 'assets/waiter.png',
        ),
        actions: [],
        bottom: TabBar(
          isScrollable: true,
          onTap: (index) {},
          controller: _controller,
          tabs: lists,
          labelColor: Palette.colorTextOnPink,
          unselectedLabelColor: Palette.unselectedItemColor,
        ),
      ),
      drawer: DrawerApp(),
      body: TabBarView(
        controller: _controller,
        children: _buildItemPost(),
      ),
    );
  }
}
