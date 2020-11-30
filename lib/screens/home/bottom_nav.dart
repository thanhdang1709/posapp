import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mdi/mdi.dart';
import 'package:pos_app/screens/pos/pos.dart';
import 'package:pos_app/widgets/flexi_top_background.dart';
import 'dart:ui' as ui;

import 'package:pos_app/widgets/ui_design/shader_maker.dart';

class MyBottomNavHome extends StatefulWidget {
  MyBottomNavHome({Key key}) : super(key: key);

  @override
  _MyBottomNavHomeState createState() => _MyBottomNavHomeState();
}

class _MyBottomNavHomeState extends State<MyBottomNavHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    PosScreen(),
    Text(
      'Index 1: Bếp',
      style: optionStyle,
    ),
    Text(
      'Index 2: POS',
      style: optionStyle,
    ),
    Text(
      'Index 3: Setting',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomBarItem(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

List<BottomNavigationBarItem> _buildBottomBarItem() {
  return <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      activeIcon: ShaderMaskCustom(
        icon: Icons.home,
      ),
      icon: Icon(Icons.home, color: Colors.grey),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      activeIcon: ShaderMaskCustom(
        icon: Icons.kitchen,
      ),
      icon: Icon(Icons.kitchen, color: Colors.grey),
      label: 'Bếp',
    ),
    BottomNavigationBarItem(
      activeIcon: ShaderMaskCustom(
        icon: Icons.point_of_sale,
      ),
      icon: Icon(Icons.point_of_sale, color: Colors.grey),
      label: ('POS'),
    ),
    BottomNavigationBarItem(
      activeIcon: ShaderMaskCustom(
        icon: Icons.settings,
      ),
      icon: Icon(Icons.settings, color: Colors.grey),
      label: ('Cài đặt'),
    ),
  ];
}
