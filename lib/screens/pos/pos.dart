import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/screens/pos/components/pos_item.dart';
import 'package:pos_app/widgets/flexi_top_background.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({Key key}) : super(key: key);

  @override
  _PosScreenState createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: lists.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        leading: Icon(Icons.menu),
        title: const Text(
          'Pos',
          style: TextStyle(color: Colors.orange),
        ),
        flexibleSpace: FlexibleTopBackground(
          assetsImage: 'assets/img1.jpg',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(FontAwesome.table),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(FontAwesome.user_plus),
          )
        ],
        bottom: TabBar(
          isScrollable: true,
          onTap: (index) {},
          controller: _controller,
          tabs: lists,
          labelColor: Pallate.selectedItemColor,
          unselectedLabelColor: Pallate.unselectedItemColor,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _buildItemPost(),
      ),
    );
  }
}

//get catelo
List<Widget> lists = [
  Tab(icon: Text('Tất cả')),
  Tab(icon: Text('Đồ uống')),
  Tab(icon: Text('Đồ ăn')),
];

//get list item
_buildItemPost() {
  return [
    TabPosItem(),
    TabPosItem(),
    TabPosItem(),
  ];
}
