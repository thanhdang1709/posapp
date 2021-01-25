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
  //pending 0
  //confirm 2
  //payment 1
  //cooking 3
  //cooked 4
  //ready 5
  //cancel 6

  Color get statusColor {
    switch (title) {
      case 'pending':
        return Colors.black45;
        break;
      case 'confirm':
        return Colors.cyan;
        break;
      case 'payment':
        return Colors.green;
        break;
      case 'cooking':
        return Colors.orangeAccent;
        break;
      case 'cooked':
        return Colors.deepOrange;
        break;
      case 'ready':
        return Colors.greenAccent;
        break;
      case 'cancel':
        return Colors.red;
        break;
      default:
        return Colors.green;
    }
  }

  String get statusLabel {
    switch (title) {
      case 'pending':
        return 'Chờ xác nhận';
        break;
      case 'confirm':
        return 'Đã xác nhận';
        break;
      case 'payment':
        return 'Đã thanh toán';
        break;
      case 'cooking':
        return 'Đang chế biến';
        break;
      case 'cooked':
        return 'Đã chế biến';
        break;
      case 'ready':
        return 'Sẵn sàng';
        break;
      case 'cancel':
        return 'Đã huỷ';
        break;
      default:
        return '';
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
      case 'cooked':
        return MdiIcons.database;
        break;
      case 'ready':
        return MdiIcons.checkAll;
        break;
      case 'cancel':
        return MdiIcons.cancel;
        break;
      default:
        return MdiIcons.clock;
    }
  }
}
