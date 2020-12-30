import 'package:pos_app/models/employee.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/table_model.dart';

class OrderModel {
  int id;
  String orderCode;
  List<ProductModel> items;
  List<int> status;
  DateTime timeStart;
  DateTime timeEnd;

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
    this.amountReceive,
    this.change,
    this.employee,
    this.table,
  });
}
