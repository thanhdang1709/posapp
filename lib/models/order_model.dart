import 'package:pos_app/models/employee.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/status_model.dart';
import 'package:pos_app/models/table_model.dart';

class OrderModel {
  int id;
  String orderCode;
  List<ProductModel> products;
  List<StatusModel> status;
  String timeStart;
  String timeEnd;
  int totalPrice;
  int amountReceive;
  int change;
  TableModel table;
  EmployeeModel employee;
  DateTime createdAt;
  int date;
  String note;

  OrderModel(
      {this.id,
      this.orderCode,
      this.products,
      this.status,
      this.timeStart,
      this.timeEnd,
      this.totalPrice,
      this.amountReceive,
      this.change,
      this.employee,
      this.table,
      this.createdAt,
      this.date,
      this.note});

  // factory OrderModel.fromJson(json) {
  //   return new OrderModel(
  //     id: json['id'],
  //     orderCode: json['order_code'],
  //     products: (json['products']).map((e) => ProductModel.fromJson(e)).toList(),
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
      products = new List<ProductModel>();
      json['products'].forEach((v) {
        products.add(new ProductModel.fromJson(v));
      });
      createdAt = DateTime.parse(json['created_at']).toLocal();
      date = DateTime.parse(json['created_at']).toLocal().day;
      note = json['note'];
    }
  }

  List<ProductModel> mapJsonProduct(json) {
    return json.map((e) => ProductModel.fromJson(e)).toList();
  }
}
