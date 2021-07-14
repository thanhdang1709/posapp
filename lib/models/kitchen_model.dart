import 'package:pos_app/contants.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/models/product_model.dart';

class KitchenModel {
  int id;
  String storeId;
  int orderId;
  int productId;
  int status;
  String createdAt;
  String updatedAt;
  int updatedBy;
  int lastStatus;
  String note;
  List<ProductModel> products;
  OrderModel order;

  KitchenModel({this.id, this.storeId, this.orderId, this.productId, this.status, this.createdAt, this.updatedAt, this.updatedBy, this.lastStatus, this.products, this.note, this.order});

  KitchenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    lastStatus = json['last_status'];
    note = json['note'];
    if (json['products'] != null) {
      products = new List<ProductModel>();
      json['products'].forEach((v) {
        products.add(new ProductModel.fromJson(v));
      });
    }
    order = json['order'] != null ? OrderModel.fromJson(json['order']) : null;
  }

  String get labelStatus {
    switch (status) {
      case 1:
        return CONTANTS.KITCHEN_STATUS[0]['label'];
        break;
      case 2:
        return CONTANTS.KITCHEN_STATUS[1]['label'];
        break;
      case 3:
        return CONTANTS.KITCHEN_STATUS[2]['label'];
        break;
      case 4:
        return CONTANTS.KITCHEN_STATUS[3]['label'];
        break;
      case 5:
        return CONTANTS.KITCHEN_STATUS[4]['label'];
        break;
      default:
        return CONTANTS.KITCHEN_STATUS[0]['label'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['last_status'] = this.lastStatus;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
