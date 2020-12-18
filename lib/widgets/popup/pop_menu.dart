import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopMenuCustom extends StatelessWidget {
  PopMenuCustom({
    Key key,
    this.icon = Icons.more_horiz,
    this.onSelected,
    this.mapItems,
  }) : super(key: key);
  final IconData icon;
  final Function onSelected;

  final List<Map<String, dynamic>> mapItems;
  List<PopupMenuItem> items = [];
  @override
  Widget build(BuildContext context) {
    mapItems.forEach((v) {
      items
        ..add(new PopupMenuItem<String>(
          child: Row(
            children: [
              Icon(v['icon']),
              SizedBox(
                width: 5,
              ),
              Text(v['title']),
            ],
          ),
          value: v['value'],
        ));
    });
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      icon: Icon(icon),
      onSelected: onSelected,
      itemBuilder: (_) => items,
    );
  }
}
