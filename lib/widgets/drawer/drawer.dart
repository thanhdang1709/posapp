import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/pos_controller.dart';
import 'package:pos_app/screens/auth/auth_screen.dart';
import 'package:pos_app/screens/auth/login_page.dart';
import 'package:pos_app/screens/auth/welcome_page.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    int role = box.read('role');
    return SafeArea(
        child: Drawer(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            colors: [
              Pallate.primaryColor.withOpacity(0.7),
              // Pallate.secondColor.withOpacity(0.7),
              // Pallate.secondColor.withOpacity(0.7),
              Pallate.primaryColor.withOpacity(0.7),
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
                        box.read('store_name') ?? 'Cà Phê Trung Nguyên Nguyên Nguyên',
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
                        box.read('name') ?? 'Vinatech',
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
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (role == 1 || role == 2 || role == 3 || role == 4)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/pos.png',
                    title: 'Bán hàng',
                    selectedColor: Get.currentRoute == 'pos' ? Pallate.primaryColor : null,
                    onPress: () {
                      Get.put(PosController());
                      Get.offNamed(
                        'pos',
                      );
                    },
                  ),
                if (role == 1 || role == 2 || role == 3)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/checklist.png',
                    title: 'Đơn hàng',
                    selectedColor: Get.currentRoute == 'order' ? Pallate.primaryColor : null,
                    onPress: () {
                      Get.offNamed('order');
                    },
                  ),
                // ItemMenuDraw(
                //   imageUrl: 'assets/icons/table.png',
                //   title: 'Bàn',
                //   onPress: () {},
                // ),
                // ItemMenuDraw(
                //   imageUrl: 'assets/icons/cooking.png',
                //   title: 'Bếp',
                //   onPress: () {},
                // ),
                if (role == 1 || role == 2 || role == 4)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/diet.png',
                    title: 'Sản phẩm',
                    selectedColor: Get.currentRoute == '/product' ? Pallate.primaryColor : null,
                    onPress: () {
                      Get.offNamed('/product');
                    },
                  ),
                // ItemMenuDraw(
                //   imageUrl: 'assets/icons/box.png',
                //   title: 'Danh mục',
                //   onPress: () {},
                // ),
                if (role == 1 || role == 2)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/customer.png',
                    title: 'Khách hàng',
                    selectedColor: Get.currentRoute == '/customer' ? Pallate.primaryColor : null,
                    onPress: () {
                      Get.offNamed('/customer');
                    },
                  ),
                if (role == 1)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/transaction.png',
                    title: 'Giao dịch',
                    selectedColor: Get.currentRoute == '/transaction' ? Pallate.primaryColor : null,
                    onPress: () {
                      Get.offNamed('/transaction');
                    },
                  ),
                if (role == 1)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/report.png',
                    title: 'Báo cáo',
                    selectedColor: Get.currentRoute == '/analytic' ? Pallate.primaryColor : null,
                    onPress: () {
                      Get.offNamed('/analytic');
                    },
                  ),
                if (role == 1)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/user.png',
                    title: 'Nhân viên',
                    selectedColor: Get.currentRoute == 'employee' ? Pallate.primaryColor : null,
                    onPress: () {
                      Get.offNamed('employee');
                    },
                  ),
                // if (role == 1)
                //   ItemMenuDraw(
                //     imageUrl: 'assets/icons/settings.png',
                //     title: 'Cài đặt',
                //     selectedColor: Get.currentRoute == '/setting' ? Pallate.primaryColor : null,
                //     onPress: () {
                //       Get.offNamed('/setting');
                //       print(Get.currentRoute);
                //     },
                //   ),

                ItemMenuDraw(
                  imageUrl: 'assets/icons/log-out.png',
                  title: 'Đăng xuất',
                  //selectedColor: Get.currentRoute == '/setting' ? Pallate.primaryColor : null,
                  onPress: () {
                    box.erase();
                    Get.reset();
                    Get.offAll(WelcomePage());
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
  const ItemMenuDraw({Key key, this.imageUrl, this.title, this.onPress, this.selectedColor}) : super(key: key);

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
