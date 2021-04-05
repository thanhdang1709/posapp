import 'package:flutter/material.dart';
import 'package:pos_app/models/area_model.dart';

class TableModel {
  int id;
  int userId;
  String storeId;
  int areaId;
  String name;
  String description;
  int capacity;
  int status;
  int deleted;
  String createdAt;
  String updatedAt;
  AreaModel area;

  TableModel({this.id, this.userId, this.storeId, this.areaId, this.name, this.description, this.capacity, this.status, this.deleted, this.createdAt, this.updatedAt, this.area});

  TableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    areaId = json['area_id'];
    name = json['name'];
    description = json['description'];
    capacity = json['capacity'];
    status = json['status'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    area = json['area'] != null ? new AreaModel.fromJson(json['area']) : null;
  }

  Color get colorStatus {
    switch (status) {
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.orange;
        break;
      default:
        return Colors.white;
    }
  }

  String get statusName {
    switch (status) {
      case 1:
        return "Sẵn sàng";
        break;
      case 2:
        return "Đang phục vụ";
        break;
      case 3:
        return "Tạm ngưng";
        break;
      default:
        return "Tạm nghỉ";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['area_id'] = this.areaId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['capacity'] = this.capacity;
    data['status'] = this.status;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.area != null) {
      data['area'] = this.area.toJson();
    }
    return data;
  }
}
