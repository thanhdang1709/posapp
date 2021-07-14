import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/lang/localization.dart';
import 'package:pos_app/routes/pages.dart';
import 'package:pos_app/screens/splashscreen/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'data/binding/splash_binding.dart'; // for other locales

void main() async {
  Future.delayed(
    Duration(milliseconds: 200),
    () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );
    },
  );
  initializeDateFormatting('vi');
  await GetStorage.init();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  return runApp(
    GetMaterialApp(
      initialRoute: Routes.INITIAL,
      smartManagement: SmartManagement.full,
      getPages: AppPages.pages,
      initialBinding: SplashBinding(),
      home: SplashScreen(),
      theme: ThemeData(
        fontFamily: 'roboto',
        primaryColor: Palette.primaryColor,
        accentColor: Palette.primaryColor,
      ),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      // initialBinding: box.hasData('token') ? HomeBinding() : WelcomeBinding(),
      title: 'POPOS',
      debugShowCheckedModeBanner: false,
    ),
  );
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
//     );
//     return GetMaterialApp(
//       initialBinding: HomeBinding(),
//       title: 'POPOS',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.pink),
//       home: SplashScreen(),
//       //initialRoute: Routes.INITIAL,
//       smartManagement: SmartManagement.full,
//       getPages: AppPages.pages,
//     );
//   }
// }
