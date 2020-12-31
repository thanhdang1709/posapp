import 'package:pos_app/models/employee.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/status_model.dart';
import 'package:pos_app/models/table_model.dart';

class OrderModel {
  int id;
  String orderCode;
  List<ProductModel> items;
  List<StatusModel> status;
  String timeStart;
  String timeEnd;
  int totalPrice;
  int amountReceive;
  int change;
  TableModel table;
  EmployeeModel employee;

  OrderModel({
    this.id,
    this.orderCode,
    this.items,
    this.status,
    this.timeStart,
    this.timeEnd,
    this.totalPrice,
    this.amountReceive,
    this.change,
    this.employee,
    this.table,
  });

  // factory OrderModel.fromJson(json) {
  //   return new OrderModel(
  //     id: json['id'],
  //     orderCode: json['order_code'],
  //     items: (json['products']).map((e) => ProductModel.fromJson(e)).toList(),
  //     status: json['status'],
  //     totalPrice: json['total_price'],
  //     timeStart: json['time_start'],
  //     timeEnd: json['time_end'],
  //     amountReceive: json['amount_receive'],
  //     change: json['amount_change'],
  //   );
  // }

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    if (json['status'] != null) {
      status = new List<StatusModel>();
      json['status'].forEach((v) {
        status.add(new StatusModel.fromJson(v));
      });
    }
    amountReceive = json['amount_receive'];
    change = json['amount_change'];
    totalPrice = json['total_price'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    if (json['products'] != null) {
      items = new List<ProductModel>();
      json['products'].forEach((v) {
        items.add(new ProductModel.fromJson(v));
      });
    }
  }

  List<ProductModel> mapJsonProduct(json) {
    return json.map((e) => ProductModel.fromJson(e)).toList();
  }
}
