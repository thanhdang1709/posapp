import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/screens/pos/components/add_new_card_item.dart';
import 'package:pos_app/screens/pos/components/grid_item.dart';
import 'package:pos_app/screens/pos/components/pos_action_row.dart';
import 'package:pos_app/screens/pos/pos_controller.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TabPosItem extends StatefulWidget {
  const TabPosItem({Key key, this.catelogId}) : super(key: key);
  final int catelogId;
  @override
  _TabPosItemState createState() => _TabPosItemState();
}

class _TabPosItemState extends State<TabPosItem>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  int count = 0;
  int total = 0;

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
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: PosActionRow(),
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
                posController.products.length,
                (index) => AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: CardFoodGridItem(
                        size: Get.size,
                        color: Colors.cyan,
                        title: posController.products[index].name,
                        price: posController.products[index].price,
                        imageUrl:
                            'https://xemhd.xyz/${posController.products[index].imageUrl}',
                        onPressed: () {
                          setState(() {
                            count += 1;
                            total += posController.products[index].price;
                          });
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
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Transform.scale(
          scale: _scale,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.cyan,
            ),
            width: Get.size.width - 20,
            padding: EdgeInsets.all(7),
            margin: EdgeInsets.all(0),
            child: Center(
                child: Text(
              '$count món = ${$Number.numberFormat(total)} đ',
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
          ),
        ),
      )
      // SizedBox(
      //   height: size.height * .3,
      // )
    ]);
  }

  List<Widget> _buildCardItem({size, color, controller}) {
    return [
      CardFoodGridItem(
        size: size,
        color: Colors.orange,
        title: 'Gà rán',
        price: 15000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      AddNewCardItem()
    ];
  }
}

bounceButtonAction(controller) {
  controller.forward();
  Future.delayed(Duration(milliseconds: 100), () {
    controller.reverse();
  });
}
