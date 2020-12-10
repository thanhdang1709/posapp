import 'package:get/get.dart';
import 'package:pos_app/screens/catelog/add/add.dart';
import 'package:pos_app/screens/customer/add/add.dart';
import 'package:pos_app/screens/customer/list/list.dart';
import 'package:pos_app/screens/pos/pos.dart';
import 'package:pos_app/screens/product/add/add.dart';
import 'package:pos_app/screens/product/list/list.dart';
import 'package:pos_app/screens/setting/list.dart';
import 'package:pos_app/screens/transaction/list/list.dart';
import 'package:pos_app/screens/welcome/onboarding_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => OnBoardingPage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => PosScreen(),
    ),
    GetPage(
      name: Routes.POS,
      page: () => PosScreen(),
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => ListProductScreen(),
      transition: Transition.rightToLeft,
      // children: [
      //   GetPage(
      //     name: 'add',
      //     page: () => AddProductScreen(),
      //   )}
    ),
    GetPage(
      name: Routes.ADD_PRODUCT,
      page: () => AddProductScreen(),
    ),
    GetPage(
      name: Routes.CATELOG,
      page: () => AddProductScreen(),
    ),
    GetPage(
      name: Routes.ADD_CATELOG,
      page: () => AddCatelogScreen(),
    ),
    GetPage(
      name: Routes.CUSTOMER,
      page: () => CustomerScreen(),
    ),
    GetPage(
      name: Routes.ADD_CUSTOMER,
      page: () => AddCustomerScreen(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingScreen(),
    ),
    GetPage(
      name: Routes.TRANSACTION,
      page: () => TransactionScreen(),
    ),
  ];
}
