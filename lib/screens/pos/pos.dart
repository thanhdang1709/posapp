import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/screens/pos/components/pos_item.dart';
import 'package:pos_app/data/controllers/pos_controller.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';
import 'package:pos_app/widgets/flexi_top_background.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({Key key}) : super(key: key);

  @override
  _PosScreenState createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> with SingleTickerProviderStateMixin {
  TabController _controller;
  // ignore: unused_field
  int _selectedIndex = 0;
  //get catelo
  List<Widget> lists = [
    Tab(
      icon: Text('Tất cả'),
    )
  ];

  var box = GetStorage();
  ProductStore posStore = Get.find<ProductStore>();
  PosController posController = Get.find<PosController>();
  //CartController cartController = Get.put(CartController());
  @override
  void initState() {
    posStore.catelogies.forEach(
      (element) => lists
        ..add(
          Tab(
            icon: Text(element.name),
          ),
        ),
    );
    _controller = TabController(length: posStore.catelogies.length + 1, vsync: this);
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
      posStore.catelogies.forEach(
        (e) => buildItem
          ..add(
            TabPosItem(
              catelogId: e.id,
            ),
          ),
      );
      return buildItem
        ..insert(
          0,
          TabPosItem(
            catelogId: 0,
          ),
        );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: const Text(
          'Máy POS',
          //style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: FlexibleTopBackground(
          assetsImage: 'assets/waiter.png',
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 20),
          //   child: Icon(FontAwesome.table),
          // ),
          // Obx(() => cartController.selectedCustomer.value.name != null
          //     ? Container(
          //         alignment: Alignment.center,
          //         padding: EdgeInsets.only(left: 5, right: 5),
          //         decoration: BoxDecoration(
          //             border: Border.all(
          //           color: Colors.white,
          //         )),
          //         child: Text(cartController.selectedCustomer.value.name, style: TextStyle(fontWeight: FontWeight.w700)),
          //       )
          //     : Text('')),
          // SizedBox(
          //   width: 5,
          // ),
          // InkWell(
          //   onTap: () {
          //     Get.toNamed("customer");
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 10),
          //     child: Icon(FontAwesome.user),
          //   ),
          // )
        ],
        bottom: TabBar(
          isScrollable: true,
          onTap: (index) {},
          controller: _controller,
          tabs: lists,
          labelColor: Pallate.colorTextOnPink,
          unselectedLabelColor: Pallate.unselectedItemColor,
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
