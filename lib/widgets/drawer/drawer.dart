import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/data/controllers/pos_controller.dart';
import 'package:pos_app/data/store/master_storage.dart';
import 'package:pos_app/screens/auth/welcome_page.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    int role = MasterConfig().userInfo?.role;
    return SafeArea(
        child: Drawer(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            colors: [
              Palette.primaryColor.withOpacity(0.7),
              // Palette.secondColor.withOpacity(0.7),
              // Palette.secondColor.withOpacity(0.7),
              Palette.primaryColor.withOpacity(0.7),
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
                        MasterConfig().storeInfo?.name ?? 'Cà Phê Trung Nguyên Nguyên Nguyên',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Palette.textStyle().copyWith(fontSize: 18, color: Colors.white),
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
                        MasterConfig().userInfo?.name ?? 'Vinatech',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.purple,
                      label: Text(
                        'label.free'.tr,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 5,
                ),
                if (role == 1 || role == 2 || role == 3 || role == 4)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/pos.png',
                    title: 'label.pos'.tr,
                    selectedColor: Get.currentRoute == 'pos' ? Palette.primaryColor : null,
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
                    title: 'label.order'.tr,
                    selectedColor: Get.currentRoute == 'order' ? Palette.primaryColor : null,
                    onPress: () {
                      Get.offNamed('order');
                    },
                  ),
                if (role == 1 || role == 2 || role == 3)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/table.png',
                    title: 'label.table'.tr,
                    selectedColor: Get.currentRoute == 'table' ? Palette.primaryColor : null,
                    onPress: () {
                      Get.offNamed('table');
                    },
                  ),
                if (role == 1 || role == 2 || role == 3)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/cooking.png',
                    title: 'label.kitchen'.tr,
                    selectedColor: Get.currentRoute == 'kitchen' ? Palette.primaryColor : null,
                    onPress: () {
                      Get.offNamed('kitchen');
                    },
                  ),
                if (role == 1 || role == 2 || role == 4)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/diet.png',
                    title: 'label.product'.tr,
                    selectedColor: Get.currentRoute == '/product' ? Palette.primaryColor : null,
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
                    title: 'label.customer'.tr,
                    selectedColor: Get.currentRoute == '/customer' ? Palette.primaryColor : null,
                    onPress: () {
                      Get.offNamed('/customer');
                    },
                  ),
                if (role == 1)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/transaction.png',
                    title: 'label.transaction'.tr,
                    selectedColor: Get.currentRoute == '/transaction' ? Palette.primaryColor : null,
                    onPress: () {
                      Get.offNamed('/transaction');
                    },
                  ),
                if (role == 1)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/report.png',
                    title: 'label.report'.tr,
                    selectedColor: Get.currentRoute == '/analytic' ? Palette.primaryColor : null,
                    onPress: () {
                      Get.offNamed('/analytic');
                    },
                  ),
                if (role == 1)
                  ItemMenuDraw(
                    imageUrl: 'assets/icons/user.png',
                    title: 'label.employee'.tr,
                    selectedColor: Get.currentRoute == 'employee' ? Palette.primaryColor : null,
                    onPress: () {
                      Get.offNamed('employee');
                    },
                  ),
                // if (role == 1)
                //   ItemMenuDraw(
                //     imageUrl: 'assets/icons/settings.png',
                //     title: 'common.settings'.tr,
                //     selectedColor: Get.currentRoute == '/setting' ? Palette.primaryColor : null,
                //     onPress: () {
                //       Get.offNamed('/setting');
                //       print(Get.currentRoute);
                //     },
                //   ),

                ItemMenuDraw(
                  imageUrl: 'assets/icons/log-out.png',
                  title: 'account.logout'.tr,
                  //selectedColor: Get.currentRoute == '/setting' ? Palette.primaryColor : null,
                  onPress: () {
                    box.erase();
                    Get.reset();
                    Get.offAll(WelcomePage());
                  },
                ),
                Divider(),
                Text('${'common.version'.tr}: 1.0',
                    style: Palette.textStyle().copyWith(
                      color: Colors.white,
                    )),
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
                style: Palette.textStyle().copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
