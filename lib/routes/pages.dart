import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/data/binding/cart_binding.dart';
import 'package:pos_app/data/binding/customer_binding.dart';
import 'package:pos_app/data/binding/home_binding.dart';
import 'package:pos_app/screens/auth/welcome_page.dart';
import 'package:pos_app/screens/cart/index.dart';
import 'package:pos_app/screens/catelog/add/add.dart';
import 'package:pos_app/screens/customer/add/add.dart';
import 'package:pos_app/screens/customer/list/list.dart';
import 'package:pos_app/screens/pos/pos.dart';
import 'package:pos_app/data/binding/pos_binding.dart';
import 'package:pos_app/screens/product/add/add.dart';
import 'package:pos_app/screens/product/edit/edit.dart';
import 'package:pos_app/data/binding/list_binding.dart';
import 'package:pos_app/screens/product/list/list.dart';
import 'package:pos_app/screens/setting/list.dart';
import 'package:pos_app/screens/transaction/list/list.dart';
import 'package:pos_app/screens/welcome/onboarding_page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () {
          return GetStorage().hasData('first_visit')
              ? GetStorage().hasData('token')
                  ? PosScreen()
                  : WelcomePage()
              : OnBoardingPage();
        },
        binding: HomeBinding()),
    GetPage(
      name: Routes.WELCOME,
      page: () {
        return GetStorage().hasData('token') ? PosScreen() : WelcomePage();
      },
    ),
    GetPage(
      name: Routes.HOME,
      page: () => PosScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.POS,
      page: () => PosScreen(),
      binding: PosBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => ListProductScreen(),
      transition: Transition.cupertino,
      binding: ListProductBinding(),
      // children: [
      //   GetPage(
      //     name: 'add',
      //     page: () => AddProductScreen(),
      //   ),
      //   GetPage(
      //     name: 'edit',
      //     page: () => EditProductScreen(),
      //   ),
      // ],
    ),
    GetPage(
      name: Routes.ADD_PRODUCT,
      page: () => AddProductScreen(),
    ),
    GetPage(
      name: Routes.EDIT_PRODUCT,
      page: () => EditProductScreen(),
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
      binding: CustomerBinding(),
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
    GetPage(
        name: Routes.CART, page: () => CartScreen(), binding: CartBinding()),
  ];
}
