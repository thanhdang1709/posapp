import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/controllers/customer_controller.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';
import 'package:pos_app/widgets/empty_data.dart';
import 'package:pos_app/widgets/smart_refresher_success.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerScreen extends GetView<CustomerController> {
  @override
  Widget build(BuildContext context) {
    //print(Get.previousRoute);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppUltils.buildAppBar(
                  // leading: Icon(Mdi.menu),
                  height: CONTANTS.HEIGHT_APPBAR,
                  title: 'Khách hàng (${controller.totalCustomer.value ?? 0})',
                  actions: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('customer/add');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.add),
                      ),
                    )
                  ],
                ),
                backgroundColor: Colors.grey.shade200,
                drawer: new DrawerApp(),
                body: Column(
                  children: [
                    // Container(
                    //   color: Colors.grey[100],
                    //   padding: EdgeInsets.only(top: 5),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(5),
                    //     child: TextFormField(
                    //       focusNode: FocusNode(),
                    //       controller: controller.searchKeyword,
                    //       decoration: InputDecoration(prefixIcon: Icon(Icons.search, size: 35), border: InputBorder.none, hintText: 'Tìm tên hoặc thông tin liên hệ'),
                    //     ),
                    //   ),
                    // ),
                    controller.searchKeyword.text.length == 0
                        ? Expanded(
                            child: SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: false,
                              header: SmartRefresherSuccess(),
                              controller: controller.refreshController,
                              onRefresh: controller.onRefresh,
                              child: PagedListView<int, CustomerModel>.separated(
                                pagingController: controller.pagingController,
                                separatorBuilder: (context, index) => Container(height: 0, color: Colors.grey.withOpacity(0.3)),
                                builderDelegate: PagedChildBuilderDelegate<CustomerModel>(
                                  itemBuilder: (context, value, index) => RowContactItem(
                                    customer: value,
                                  ),
                                  noItemsFoundIndicatorBuilder: (context) => Container(
                                    height: Get.height * 0.6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        EmptyDataWidget(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: false,
                              header: SmartRefresherSuccess(),
                              controller: controller.refreshController,
                              onRefresh: controller.onRefresh,
                              child: ListView(
                                children: [
                                  ...controller.searchResults
                                      .map((e) => RowContactItem(
                                            customer: e,
                                          ))
                                      .toList()
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              ),
      ),
    );
  }
}

class RowContactItem extends StatelessWidget {
  const RowContactItem({
    Key key,
    this.customer,
    this.gradient = null,
  }) : super(key: key);

  final CustomerModel customer;
  final List<Color> gradient;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    CartController cartController = Get.put(CartController());
    print(Get.previousRoute);
    return InkWell(
      onTap: () {
        if (Get.previousRoute == 'cart' || Get.previousRoute == 'payment') {
          cartController.selectedCustomer.value = customer;
          Get.back();
        } else {
          // cartController.selectCustomer(customer);

          Get.toNamed('customer/detail', arguments: customer);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.green.shade500,
          gradient: new LinearGradient(
              colors: gradient ??
                  [
                    Palette.primaryColor,
                    Palette.secondColor,
                  ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 3,
              offset: Offset(4, 6), // Shadow position
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customer.name.toString(),
              style: Palette.textStyle().copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Chưa có giao dịch', style: TextStyle(color: Colors.white)),
                Icon(
                  FontAwesome.chevron_right,
                  size: 20,
                  color: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
