import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.7),
              Colors.cyan.withOpacity(0.7),
              Colors.cyan.withOpacity(0.7),
              Colors.blue.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Cà Phê Trung Nguyên Nguyên Nguyên',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Pallate.textTitle1(),
                      ),
                    ),
                    Icon(
                      FontAwesome.chevron_right,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Cao Thanh Đẳng',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.purple,
                      label: Text(
                        'Miễn phí',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ItemMenuDraw(
                  imageUrl: 'assets/icons/pos.png',
                  title: 'Bán hàng',
                  selectedColor:
                      Get.currentRoute == '/pos' ? Colors.blue[300] : null,
                  onPress: () {
                    Get.offNamed('/pos');
                  },
                ),
                ItemMenuDraw(
                  imageUrl: 'assets/icons/table.png',
                  title: 'Bàn',
                  onPress: () {},
                ),
                ItemMenuDraw(
                  imageUrl: 'assets/icons/cooking.png',
                  title: 'Bếp',
                  onPress: () {},
                ),
                ItemMenuDraw(
                  imageUrl: 'assets/icons/diet.png',
                  title: 'Sản phẩm',
                  selectedColor:
                      Get.currentRoute == '/product' ? Colors.blue[300] : null,
                  onPress: () {
                    Get.offNamed('/product');
                  },
                ),
                // ItemMenuDraw(
                //   imageUrl: 'assets/icons/box.png',
                //   title: 'Danh mục',
                //   onPress: () {},
                // ),
                ItemMenuDraw(
                  imageUrl: 'assets/icons/customer.png',
                  title: 'Khách hàng',
                  selectedColor:
                      Get.currentRoute == '/customer' ? Colors.blue[300] : null,
                  onPress: () {
                    Get.offNamed('/customer');
                  },
                ),
                ItemMenuDraw(
                  imageUrl: 'assets/icons/transaction.png',
                  title: 'Giao dịch',
                  selectedColor: Get.currentRoute == '/transaction'
                      ? Colors.blue[300]
                      : null,
                  onPress: () {
                    Get.offNamed('/transaction');
                  },
                ),
                ItemMenuDraw(
                  imageUrl: 'assets/icons/report.png',
                  title: 'Báo cáo',
                  onPress: () {},
                ),
                ItemMenuDraw(
                  imageUrl: 'assets/icons/user.png',
                  title: 'Nhân viên',
                  onPress: () {},
                ),
                ItemMenuDraw(
                  imageUrl: 'assets/icons/settings.png',
                  title: 'Cài đặt',
                  selectedColor:
                      Get.currentRoute == '/setting' ? Colors.blue[300] : null,
                  onPress: () {
                    Get.offNamed('/setting');
                    print(Get.currentRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class ItemMenuDraw extends StatelessWidget {
  const ItemMenuDraw(
      {Key key, this.imageUrl, this.title, this.onPress, this.selectedColor})
      : super(key: key);

  final String imageUrl;
  final String title;
  final Function onPress;
  final Color selectedColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(5),
        color: selectedColor ?? Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Image.asset(
                imageUrl,
                height: 40,
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                  child: Text(
                title,
                style: Pallate.textTitle2(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
