import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/app/controllers/table_controller.dart';
import 'package:pos_app/app/screens/table/add_area_screen.dart';
import 'package:pos_app/app/screens/table/area/list/list.dart';
import 'package:pos_app/app/screens/table/components/table_list.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';
import 'package:pos_app/widgets/flexi_top_background.dart';

import 'components/add_table_screen.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key key}) : super(key: key);

  @override
  _PosScreenState createState() => _PosScreenState();
}

class _PosScreenState extends State<TableScreen> with SingleTickerProviderStateMixin {
  TabController _controller;
  // ignore: unused_field
  int _selectedIndex = 0;
  //get catelo
  List<Widget> lists = [
    Tab(
      icon: Text('common.all'.tr),
    )
  ];

  var box = GetStorage();
  MasterStore masterStore = Get.find();
  TableController tableController = Get.put<TableController>(TableController());
  @override
  void initState() {
    masterStore.areaList.forEach(
      (element) => lists
        ..add(
          Tab(
            icon: Text(element.name),
          ),
        ),
    );
    _controller = TabController(length: masterStore.areaList.length + 1, vsync: this);
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
      masterStore.areaList.forEach(
        (e) => buildItem.add(
          TableList(
            areaId: e.id,
          ),
        ),
      );

      buildItem
        ..insert(
          0,
          TableList(
            areaId: 0,
          ),
        );
      return buildItem;
    }

    return Obx(
      () => !tableController.isLoading.value
          ? Scaffold(
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 100,
                title: Text(
                  'label.table'.tr,
                  //style: TextStyle(color: Colors.white),
                ),
                flexibleSpace: FlexibleTopBackground(
                  assetsImage: 'assets/waiter.png',
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      Get.to(AreaScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(FontAwesome.table),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(AddTableScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(FontAwesome.plus),
                    ),
                  )
                ],
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
            )
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 100,
                title: Text(
                  'label.table'.tr,
                  //style: TextStyle(color: Colors.white),
                ),
                flexibleSpace: FlexibleTopBackground(
                  assetsImage: 'assets/waiter.png',
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      Get.to(AreaScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(FontAwesome.plus),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(AddTableScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(FontAwesome.table),
                    ),
                  )
                ],
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
            ),
    );
  }
}
