import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos_app/app/controllers/confirm_table_controller.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/models/kitchen_model.dart';
import 'package:get/get.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:pos_app/widgets/empty_data.dart';
import 'package:pos_app/widgets/smart_refresher_success.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

class TableList extends StatefulWidget {
  const TableList({Key key, this.statusId}) : super(key: key);
  final int statusId;
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> with SingleTickerProviderStateMixin {
  double scale;
  AnimationController _controller;
  int count = 0;
  int total = 0;

  List<TableModel> products;
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
    ConfirmTableController controller = Get.find();
    //MasterStore posStore = Get.find();
    //  List<KitchenModel> listMenu = widget.statusId != 0 ? posStore.tables.where((element) => element.areaId == widget.areaId).toList() : posStore.tables;
    return Column(children: [
      SizedBox(
        height: 5,
      ),
      Expanded(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: SmartRefresherSuccess(),
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child: PagedListView<int, TableModel>.separated(
            pagingController: controller.pagingController,
            separatorBuilder: (context, index) => Container(height: 6, color: Colors.grey.withOpacity(0.3)),
            builderDelegate: PagedChildBuilderDelegate<TableModel>(
              itemBuilder: (context, table, index) => ExpandKitchenItem(
                table: table,
                callback: (status) {
                  controller.onUpdateStatus(id: table.id, status: status);
                },
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
      ),
    ]);
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
}

bounceButtonAction(controller) {
  controller.forward();
  Future.delayed(Duration(milliseconds: 100), () {
    controller.reverse();
  });
}

class ExpandKitchenItem extends StatelessWidget {
  const ExpandKitchenItem({this.table, this.callback}) : super();
  final TableModel table;
  final Function callback;
  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      key: new GlobalKey(),
      animateTrailing: true,
      initiallyExpanded: (table.id != null) ? true : false,
      title: Row(
        children: [
          Text(
            table.name ?? '',
            style: Palette.textStyle().copyWith(
              fontSize: 18,
            ),
          ),
        ],
      ),
      subtitle: Text(
        table.statusName ?? '',
        style: Palette.textStyle().copyWith(color: Colors.green),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 10),
          child: Row(
            children: [Expanded(child: Text('Thời gian: ${DateFormat('H:mm dd/MM/yy').format(DateTime.parse(table.updatedAt).toLocal()) ?? ''}'))],
          ),
        ),
        Padding(
            padding: EdgeInsets.all(0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      callback(2);
                    },
                    textTheme: ButtonTextTheme.accent,
                    child: Text('Xác nhận'),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
