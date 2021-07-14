import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/pos_controller.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/screens/pos/components/add_new_card_item.dart';
import 'package:pos_app/screens/pos/components/grid_item.dart';
import 'package:pos_app/screens/pos/components/list_item.dart';
import 'package:pos_app/screens/pos/components/pos_action_row.dart';
import 'package:pos_app/ultils/color.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pos_app/widgets/smart_refresher_success.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'add_new_list_item.dart';

class TabPosItem extends StatefulWidget {
  const TabPosItem({Key key, this.catelogId}) : super(key: key);
  final int catelogId;
  @override
  _TabPosItemState createState() => _TabPosItemState();
}

class _TabPosItemState extends State<TabPosItem> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  int count = 0;
  int total = 0;

  List<ProductModel> products;
  // print(widget.catelogId);
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
    _scale = 1 - _controller.value;
    PosController posController = Get.put(PosController());
    MasterStore posStore = Get.find();
    if (posController.searchPosController.text.isNotEmpty)
      products = widget.catelogId != 0
          ? posController.products
              .where((e) =>
                  e.catelogId == widget.catelogId &&
                  (e.name.toLowerCase().contains(posController.searchPosController.text.toLowerCase()) ||
                      // ignore: null_aware_in_logical_operator
                      e.barCode.toString().toLowerCase().contains(posController.searchPosController.text.toString().toLowerCase())))
              .toList()
          : posController.products
              .where((element) =>
                  // ignore: null_aware_in_logical_operator
                  element.name.toString()?.toLowerCase()?.contains(posController.searchPosController.text.toLowerCase()) ||
                  // ignore: null_aware_in_logical_operator
                  element.barCode.toString().toLowerCase().contains(posController.searchPosController.text.toString().toLowerCase()))
              .toList();
    else
      products = widget.catelogId != 0 ? posController.products.where((element) => element.catelogId == widget.catelogId).toList() : posController.products;
    // print(products.first.name);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: PosActionRow(),
      ),
      SizedBox(
        height: 5,
      ),

      Obx(() => Expanded(
            child: posController.isListItem.value
                ? SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: SmartRefresherSuccess(),
                    controller: posController.refreshController,
                    onRefresh: posController.onRefresh,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          products.length,
                          (index) => AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: CardFoodListItem(
                                  size: Get.size,
                                  color: products[index].color == '' ? Palette.primaryColor : ColorFormat.stringToColor(products[index].color),
                                  title: products[index].name,
                                  price: products[index].price,
                                  imageUrl: '${products[index].imageUrl}',
                                  onPressed: () {
                                    posController.addToCart(products[index]);
                                    bounceButtonAction(_controller);
                                    //print('hello');
                                  },
                                ),
                              ),
                            ),
                          ),
                        )..add(AddNewListItem()),
                      ),
                    ),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: SmartRefresherSuccess(),
                    controller: posController.refreshController,
                    onRefresh: posController.onRefresh,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5, bottom: 0),
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
                            products.length,
                            (index) => AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: CardFoodGridItem(
                                    size: Get.size,
                                    color: products[index].color == '' ? Palette.primaryColor : ColorFormat.stringToColor(products[index].color),
                                    title: products[index].name,
                                    price: products[index].price,
                                    imageUrl: '${products[index].imageUrl}',
                                    onPressed: () {
                                      posController.addToCart(products[index]);
                                      bounceButtonAction(_controller);
                                      //print('hello');
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )..add(AddNewCardItem()),
                        ),
                      ),
                    ),
                  ),
          )),
      InkWell(
        onTap: () {
          if (posStore.cartItem.length != 0) {
            Get.toNamed('cart');
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Transform.scale(
            scale: _scale,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Palette.primaryColor,
              ),
              width: Get.size.width - 20,
              height: 50,
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.all(0),
              child: Center(
                  child: Obx(() => Text(
                        '${posStore.cartItem.length} ${'label.item'.tr} = ${$Number.numberFormat(posStore.cartItem.length != 0 ? posStore.cartItem?.map((element) => element.price)?.reduce((a, b) => a + b) : 0)} đ',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ))),
            ),
          ),
        ),
      )
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
