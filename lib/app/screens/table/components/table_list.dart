import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/app/controllers/table_controller.dart';
import 'package:pos_app/app/screens/table/components/edit_table_screen.dart';
import 'package:pos_app/app/screens/table/components/grid_item.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/popup/pop_menu.dart';
import 'package:pos_app/widgets/smart_refresher_success.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TableList extends StatefulWidget {
  const TableList({Key key, this.areaId}) : super(key: key);
  final int areaId;
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> with SingleTickerProviderStateMixin {
  double scale;
  AnimationController _controller;
  int count = 0;
  int total = 0;

  List<ProductModel> products;
  // print(widget.areaId);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - _controller.value;
    CartController cartController = Get.put(CartController());
    TableController tableController = Get.put(TableController());
    MasterStore posStore = Get.find();
    List<TableModel> tables = widget.areaId != 0 ? posStore.listTable.where((element) => element.areaId == widget.areaId).toList() : posStore.listTable;

    _tapDown(TapDownDetails details, table) {
      double left = details.globalPosition.dx;
      double top = details.globalPosition.dy;
      showMenu<String>(
        context: Get.context,
        position: RelativeRect.fromLTRB(left, top, 100000, 0),
        items: [
          PopupMenuItem<String>(child: Text('Chọn bàn'), value: '0'),
          PopupMenuItem<String>(child: Text('Xác nhận'), value: '1'),
          PopupMenuItem<String>(child: const Text('Sửa'), value: '2'),
          PopupMenuItem<String>(child: Text('Xoá'), value: '3'),
        ],
        elevation: 8.0,
      ).then<void>((String itemSelected) {
        if (itemSelected == null) return;
        if (itemSelected == "0") {
          if (table.status == 1) {
            cartController.selectedTable.value = table;
            Get.back();
          } else {
            AppUltils().getSnackBarError(title: 'Thất bại', message: 'Bàn này đang phục vụ, vui lòng chọn bàn khác');
          }
        } else if (itemSelected == "1") {
        } else if (itemSelected == "2") {
          tableController.selectedTable = table;
          Get.to(EditTableScreen());
        } else {
          tableController.onDeleteTable(table);
        }
      });
    }

    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: SmartRefresherSuccess(),
            controller: tableController.refreshController,
            onRefresh: tableController.onRefreshTable,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
              child: AnimationLimiter(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.8,
                  controller: new ScrollController(keepScrollOffset: true),
                  scrollDirection: Axis.vertical,
                  // children: _buildCardItem(
                  //     size: Get.size, color: Colors.orange, controller: _controller),
                  children: List.generate(
                    tables.length,
                    (index) => AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: CardTableGridItem(
                            size: Get.size,
                            color: Palette.primaryColor,
                            name: tables[index].name,
                            status: tables[index].statusName,
                            colorStatus: tables[index].colorStatus,
                            capacity: tables[index].capacity,
                            tapDown: (details) {
                              if (Get.previousRoute == 'cart' || Get.previousRoute == 'payment') {
                                if (tables[index].status == 1) {
                                  cartController.selectedTable.value = tables[index];
                                  Get.back();
                                } else {
                                  AppUltils().getSnackBarError(title: 'Thất bại', message: 'Bàn này đang phục vụ, vui lòng chọn bàn khác');
                                }
                              } else {
                                _tapDown(details, tables[index]);
                              }
                            },
                            onPressed: () async {
                              //Get.offAllNamed('cart', arguments: {'table_id': tables[index].id});
                              // if (Get.previousRoute == 'cart' || Get.previousRoute == 'payment') {
                              //   cartController.selectedTable.value = tables[index];
                              //   Get.back();
                              // } else {
                              //   // cartController.selectCustomer(customer);
                              //   // Get.toNamed('customer/detail', arguments: customer);
                              // }
                              // posController.addToCart(products[index]);
                              // bounceButtonAction(_controller);
                              //print('hello');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     if (posStore.cartItem.length != 0) {
          //       Get.toNamed('cart');
          //     }
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          //     child: Transform.scale(
          //       scale: _scale,
          //       child: Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: Palette.primaryColor,
          //         ),
          //         width: Get.size.width - 20,
          //         height: 50,
          //         padding: EdgeInsets.all(7),
          //         margin: EdgeInsets.all(0),
          //         child: Center(
          //             child: Obx(() => Text(
          //                   '${posStore.cartItem.length} ${'label.item'.tr} = ${$Number.numberFormat(posStore.cartItem.length != 0 ? posStore.cartItem?.map((element) => element.price)?.reduce((a, b) => a + b) : 0)} đ',
          //                   style: TextStyle(color: Colors.white, fontSize: 25),
          //                 ))),
          //       ),
          //     ),
          //   ),
          // )
          // SizedBox(
          //   height: size.height * .3,
          // )
        ),
      ],
    );
  }

  // ignore: unused_element
  // List<Widget> _buildCardItem({size, color, controller}) {
  //   return [
  //     CardFoodGridItem(
  //       size: size,
  //       color: Colors.orange,
  //       title: 'Gà rán',
  //       price: 15000,
  //       imageUrl: 'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
  //       onPressed: () {
  //         setState(() {
  //           count += 1;
  //         });
  //         bounceButtonAction(controller);
  //         //print('hello');
  //       },
  //     ),
  //     AddNewCardItem()
  //   ];
  // }

}

bounceButtonAction(controller) {
  controller.forward();
  Future.delayed(Duration(milliseconds: 100), () {
    controller.reverse();
  });
}
