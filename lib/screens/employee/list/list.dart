import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/controllers/employee_controller.dart';
import 'package:pos_app/models/employee.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

class EmployeeScreen extends GetView<EmployeeController> {
  @override
  Widget build(BuildContext context) {
    //print(Get.previousRoute);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppUltils.buildAppBar(
          // leading: Icon(Mdi.menu),
          height: 40,
          title: 'Nhân viên',
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed('employee/add');
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
        drawer: new DrawerApp(),
        body: Column(
          children: [
            Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  focusNode: FocusNode(),
                  controller: controller.searchKeyword,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.search, size: 35), border: InputBorder.none, hintText: 'Tìm tên nhân viên'),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() => !controller.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.all(15),
                        child: controller.employees.length != 0
                            ? controller.searchResults.length == 0
                                ? Column(
                                    children: List.generate(
                                      controller.employees.length,
                                      (index) => RowContactItem(employee: controller.employees[index]),
                                    ),
                                  )
                                : Column(
                                    children: List.generate(
                                      controller.searchResults.length,
                                      (index) => RowContactItem(employee: controller.searchResults[index]),
                                    ),
                                  )
                            : Image.asset(
                                'assets/img/empty.png',
                                height: Get.height * .2,
                              ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RowContactItem extends StatelessWidget {
  const RowContactItem({
    Key key,
    this.employee,
  }) : super(key: key);

  final EmployeeModel employee;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    CartController cartController = Get.put(CartController());
    print(Get.previousRoute);
    return InkWell(
      onTap: () {},
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  employee.name.toString(),
                  style: Palette.titleProduct(),
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Palette.primaryColor)),
                  padding: EdgeInsets.all(5),
                  child: Text(employee.roleLabel),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(employee.email, style: TextStyle(color: Colors.grey)),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng đơn: ' + employee.totalOrder.toString() ?? 'chưa có đơn', style: TextStyle(color: Colors.grey)),
                Icon(
                  FontAwesome.chevron_right,
                  size: 10,
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
