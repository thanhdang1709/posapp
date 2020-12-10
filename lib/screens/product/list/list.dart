import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/screens/product/list/components/item_catelog.dart';
import 'package:pos_app/screens/product/list/components/item_product.dart';
import 'package:pos_app/screens/product/list/components/item_product_stock.dart';
import 'package:pos_app/widgets/common/row_search_input.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key key}) : super(key: key);

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  // ignore: unused_field
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: listCatelogies.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 80,
        title: 'Sản phẩm (0)',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Mdi.plus),
          )
        ],
        tabBar: TabBar(
          isScrollable: false,
          onTap: (index) {},
          controller: _controller,
          tabs: listCatelogies,
          labelColor: Pallate.selectedItemColor,
          unselectedLabelColor: Pallate.unselectedItemColor,
        ),
      ),
      drawer: DrawerApp(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: TabBarView(
          controller: _controller,
          children: _buildItemPost(),
        ),
      ),
    );
  }
}

//get catelo
List<Widget> listCatelogies = [
  Tab(icon: Text('Sản phẩm')),
  Tab(icon: Text('Kho')),
  Tab(icon: Text('Danh mục')),
];

//get list item
_buildItemPost() {
  return [
    ColumnListProduct(),
    ColumnListProductStock(),
    ColumnListCatelog(),
  ];
}

class ColumnListCatelog extends StatefulWidget {
  const ColumnListCatelog({
    Key key,
  }) : super(key: key);

  @override
  _ColumnListCatelogState createState() => _ColumnListCatelogState();
}

class _ColumnListCatelogState extends State<ColumnListCatelog> {
  bool isOpenAddCat = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: RowSearchInput(
              hintText: 'Tìm danh mục',
              iconRight: isOpenAddCat ? Icons.close : Icons.add,
              onPressIcon: () {
                //Get.toNamed('catelog/add');
                setState(() {
                  isOpenAddCat = !isOpenAddCat;
                });
              },
            ),
          ),
        ),
        //TweenAnimationBuilder(tween: null, duration: null, builder: null),
        if (isOpenAddCat)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Thêm danh mục',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.save),
                  ],
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ItemCatelog(),
            ],
          ),
        ),
      ],
    );
  }
}

class ColumnListProductStock extends StatelessWidget {
  const ColumnListProductStock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: RowSearchInput(
              iconRight: Mdi.filterMenuOutline,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                return ItemProductStock();
              },
            ),
          ),
        ),
        Container(
          height: Get.height * .13,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              // backgroundBlendMode: BlendMode.color,
              color: Colors.blueGrey),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng: 8.000.000 đ',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      '90',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng giá trị kho: 8.000.000 đ',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'còn hàng',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ColumnListProduct extends StatelessWidget {
  const ColumnListProduct({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: RowSearchInput(onPressIcon: () {
              Get.toNamed('/product/add');
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              ItemProduct(),
              Divider(),
              ItemProduct(),
              Divider(),
              ItemProduct(),
              Divider(),
              ItemProduct(),
              Divider(),
              ItemProduct(),
              Divider(),
            ],
          ),
        ),
      ],
    );
  }
}