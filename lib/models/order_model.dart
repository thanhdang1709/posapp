import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/models/employee.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/status_model.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:pos_app/models/user_model.dart';

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
  int tableId;
  TableModel table;
  EmployeeModel employee;
  CustomerModel customer;
  DateTime createdAt;
  int date;
  String note;
  UserModel client;
  int paymentMethod;
  int orderMethod;

  OrderModel({
    this.id,
    this.orderCode,
    this.products,
    this.status,
    this.timeStart,
    this.timeEnd,
    this.totalPrice,
    this.amountReceive,
    this.change,
    this.employee,
    this.customer,
    this.tableId,
    this.table,
    this.createdAt,
    this.date,
    this.note,
    this.client,
    this.orderMethod,
    this.paymentMethod,
  });

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
    tableId = json['table_id'];
    table = (json['table']) != null ? TableModel.fromJson(json['table']) : null;
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

    customer = CustomerModel.fromJson(json['customer']);
    employee = EmployeeModel.fromJson(json['user']);
    if (json['client'] != null) {
      client = UserModel.fromJson(json['client']);
    }
    paymentMethod = json['payment_method'];
    orderMethod = json['order_method'];
  }

  List<ProductModel> mapJsonProduct(json) {
    return json.map((e) => ProductModel.fromJson(e)).toList();
  }

  String get orderMethoLabel {
    switch (orderMethod) {
      case 1:
        return 'Dùng tại chỗ';
        break;
      case 2:
        return 'Mang về';
        break;
      case 3:
        return 'Giao hàng';
        break;

      default:
        return '';
    }
  }

  String get paymentMethodLabel {
    switch (paymentMethod) {
      case 1:
        return 'Tiền mặt';
        break;
      case 2:
        return 'ATM';
        break;
      case 3:
        return 'Ghi nợ';
        break;

      default:
        return '';
    }
  }
}
