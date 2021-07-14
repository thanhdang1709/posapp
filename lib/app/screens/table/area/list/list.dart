import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mdi/mdi.dart';
import 'package:pdf/widgets/progress.dart';
import 'package:pos_app/app/controllers/table_controller.dart';
import 'package:pos_app/app/screens/table/area/add/add.dart';
import 'package:pos_app/app/screens/table/area/edit/edit.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/controllers/customer_controller.dart';
import 'package:pos_app/models/area_model.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';
import 'package:pos_app/widgets/empty_data.dart';
import 'package:pos_app/widgets/smart_refresher_success.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AreaScreen extends GetView<TableController> {
  @override
  Widget build(BuildContext context) {
    TableController controller = Get.put(TableController());
    //print(Get.previousRoute);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : Scaffold(
                appBar: AppUltils.buildAppBar(
                  // leading: Icon(Mdi.menu),
                  height: CONTANTS.HEIGHT_APPBAR,
                  title: 'Khu vực',
                  actions: [
                    InkWell(
                      onTap: () {
                        Get.to(AddAreaScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.add),
                      ),
                    )
                  ],
                ),
                backgroundColor: Colors.grey.shade200,
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
                    Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        header: SmartRefresherSuccess(),
                        controller: controller.refreshController,
                        onRefresh: controller.onRefresh,
                        child: PagedListView<int, AreaModel>.separated(
                          pagingController: controller.pagingController,
                          separatorBuilder: (context, index) => Container(height: 0, color: Colors.grey.withOpacity(0.3)),
                          builderDelegate: PagedChildBuilderDelegate<AreaModel>(
                            itemBuilder: (context, value, index) => RowContactItem(area: value, controller: controller),
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
                  ],
                ),
              ),
      ),
    );
  }
}

class RowContactItem extends StatelessWidget {
  const RowContactItem({Key key, this.area, this.gradient = null, this.controller}) : super(key: key);

  final AreaModel area;
  final List<Color> gradient;
  final TableController controller;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    CartController cartController = Get.put(CartController());
    print(Get.previousRoute);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green.shade500,
        gradient: new LinearGradient(
            colors: gradient ??
                [
                  Palette.primaryColor,
                  Palette.secondColor,
                ],
            begin: const FractionalOffset(.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.circular(15),
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
            area.name.toString(),
            style: Palette.textStyle().copyWith(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Số bàn: ${area.tableCount ?? 0}', style: Palette.textStyle().copyWith(color: Colors.white)),
              Spacer(),
              InkWell(
                onTap: () {
                  controller.selectedArea = area;
                  Get.to(EditAreaScreen());
                },
                child: Icon(
                  FontAwesome.edit,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  // ignore: unnecessary_statements
                  controller.onDeleteArea(area);
                },
                child: Icon(
                  Mdi.delete,
                  size: 20,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
