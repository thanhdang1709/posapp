import 'package:flutter/material.dart';
import 'package:pos_app/config/palette.dart';

class TabHeading extends StatelessWidget {
  TabHeading({
    Key key,
    @required this.controller,
  });

  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Palette.secondColor.withOpacity(0.7),
            Palette.primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TabBar(
        unselectedLabelColor: Colors.white,
        labelColor: Colors.orange,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 4,
              color: Colors.orange,
            ),
            insets: EdgeInsets.only(left: 0, right: 8, bottom: 0)),
        tabs: controller.tabItem,
        controller: controller.tabController,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
    );
  }
}
