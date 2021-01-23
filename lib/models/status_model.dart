import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StatusModel {
  int id;
  String title;
  IconData icon;
  bool isChecked;
  String createdAt;

  StatusModel({this.id, this.title, this.createdAt, this.icon});
  factory StatusModel.fromJson(json) {
    return new StatusModel(id: json['id'], title: json['title'], createdAt: json['created_at']);
  }

  Color get statusColor {
    switch (title) {
      case 'pending':
        return Colors.black45;
        break;
      case 'confirm':
        return Colors.cyan;
        break;
      case 'pay':
        return Colors.green;
        break;
      case 'cooking':
        return Colors.orangeAccent;
        break;
      case 'cancel':
        return Colors.red;
        break;
      default:
        return Colors.green;
    }
  }

  IconData get statusIcon {
    switch (title) {
      case 'pending':
        return MdiIcons.clock;
        break;
      case 'confirm':
        return MdiIcons.clock;
        break;
      case 'payment':
        return FontAwesome.check;
        break;
      case 'cooking':
        return MdiIcons.clock;
        break;
      case 'cancel':
        return MdiIcons.clock;
        break;
      default:
        return MdiIcons.clock;
    }
  }
}
