import 'package:pos_app/models/customer_model.dart';

class ReportModel {
  int id;
  int userId;
  String storeId;
  int tableId;
  String orderCode;
  int status;
  int amountReceive;
  int amountChange;
  int totalPrice;
  String note;
  String timeStart;
  String timeEnd;
  int deleted;
  DateTime createdAt;
  DateTime updatedAt;
  List<Products> products;
  User user;
  CustomerModel customer;

  ReportModel({
    this.id,
    this.userId,
    this.storeId,
    this.tableId,
    this.orderCode,
    this.status,
    this.amountReceive,
    this.amountChange,
    this.totalPrice,
    this.note,
    this.timeStart,
    this.timeEnd,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.products,
    this.user,
    this.customer,
  });

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    tableId = json['table_id'];
    orderCode = json['order_code'];
    status = json['status'];
    amountReceive = json['amount_receive'];
    amountChange = json['amount_change'];
    totalPrice = json['total_price'];
    note = json['note'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    deleted = json['deleted'];
    createdAt = DateTime.parse(json['created_at']).toLocal();
    updatedAt = DateTime.parse(json['updated_at']).toLocal();
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    customer = CustomerModel.fromJson(json['customer']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['table_id'] = this.tableId;
    data['order_code'] = this.orderCode;
    data['status'] = this.status;
    data['amount_receive'] = this.amountReceive;
    data['amount_change'] = this.amountChange;
    data['total_price'] = this.totalPrice;
    data['note'] = this.note;
    data['time_start'] = this.timeStart;
    data['time_end'] = this.timeEnd;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['customer'] = this.customer;
    return data;
  }
}

class Products {
  int id;
  String name;
  int userId;
  String storeId;
  int catelogId;
  int stock;
  int price;
  int promoprice;
  int cost;
  int public;
  String defaultImage;
  String color;
  int deleted;
  String thumbImage;
  String barcode;
  String note;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Products({
    this.id,
    this.name,
    this.userId,
    this.storeId,
    this.catelogId,
    this.stock,
    this.price,
    this.promoprice,
    this.cost,
    this.public,
    this.defaultImage,
    this.color,
    this.deleted,
    this.thumbImage,
    this.barcode,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    storeId = json['store_id'];
    catelogId = json['catelog_id'];
    stock = json['stock'];
    price = json['price'];
    promoprice = json['promoprice'];

    cost = json['cost'];

    public = json['public'];
    defaultImage = json['default_image'];
    color = json['color'];
    deleted = json['deleted'];
    thumbImage = json['thumb_image'];
    barcode = json['barcode'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['catelog_id'] = this.catelogId;
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['promoprice'] = this.promoprice;
    data['default_image'] = this.defaultImage;
    data['color'] = this.color;
    data['deleted'] = this.deleted;
    data['thumb_image'] = this.thumbImage;
    data['barcode'] = this.barcode;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int orderId;
  int productId;

  Pivot({this.orderId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String storeId;
  String storeName;
  Null emailVerifiedAt;
  int status;
  int role;
  String createdAt;
  Null updatedAt;

  User({this.id, this.name, this.email, this.storeId, this.storeName, this.emailVerifiedAt, this.status, this.role, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
