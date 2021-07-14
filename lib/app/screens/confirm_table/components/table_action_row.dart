import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:pos_app/config/palette.dart';

class PosActionRow extends StatefulWidget {
  const PosActionRow({
    Key key,
  }) : super(key: key);

  @override
  _PosActionRowState createState() => _PosActionRowState();
}

class _PosActionRowState extends State<PosActionRow> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return !isSearch
        ? Row(
            children: [
              Icon(
                Icons.search,
                size: 30,
                color: Palette.iconActionColor,
              ),
              Spacer(),
              Icon(
                Mdi.barcodeScan,
                size: 30,
                color: Palette.iconActionColor,
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Mdi.viewGridOutline,
                size: 30,
                color: Palette.iconActionColor,
              )
            ],
          )
        : Row(children: [
            Icon(
              Icons.search,
              size: 30,
              color: Palette.iconActionColor,
            ),
          ]);
  }
}
