import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/data/binding/home_binding.dart';
import 'package:pos_app/data/binding/welcome_binding.dart';
import 'package:pos_app/routes/pages.dart';
import 'package:pos_app/screens/auth/welcome_page.dart';
import 'package:pos_app/screens/splashscreen/splash_screen.dart';
import 'package:pos_app/screens/welcome/onboarding_page.dart';
import 'package:pdf/widgets.dart' as pw;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
  );

  await GetStorage.init();
  var box = GetStorage();
  return runApp(
    GetMaterialApp(
      initialRoute: Routes.INITIAL,
      smartManagement: SmartManagement.full,
      getPages: AppPages.pages,
      initialBinding: box.hasData('token') ? HomeBinding() : WelcomeBinding(),
      title: 'POPOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: box.hasData('token')
          ? SplashScreen()
          : box.hasData('first_visit')
              ? WelcomePage()
              : OnBoardingPage(),
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
