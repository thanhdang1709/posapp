import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/app/screens/table/components/grid_item.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
    MasterStore posStore = Get.find();
    List<TableModel> tables = widget.areaId != 0 ? posStore.listTable.where((element) => element.areaId == widget.areaId).toList() : posStore.listTable;
    return Column(children: [
      SizedBox(
        height: 5,
      ),
      Expanded(
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
                        onPressed: () {
                          //Get.offAllNamed('cart', arguments: {'table_id': tables[index].id});
                          if (Get.previousRoute == 'cart' || Get.previousRoute == 'payment') {
                            cartController.selectedTable.value = tables[index];
                            Get.back();
                          } else {
                            // cartController.selectCustomer(customer);
                            // Get.toNamed('customer/detail', arguments: customer);
                          }
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
    ]);
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
