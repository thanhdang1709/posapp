import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/data/binding/home_binding.dart';
import 'package:pos_app/routes/pages.dart';
import 'package:pos_app/screens/splashscreen/splash_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.cyan, // navigation bar color
    statusBarColor: Colors.cyan, // status bar color
  ));
  await GetStorage.init();
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );
    return GetMaterialApp(
      initialBinding: HomeBinding(),
      title: 'POPOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: SplashScreen(),
      //initialRoute: Routes.INITIAL,
      smartManagement: SmartManagement.full,
      getPages: AppPages.pages,
    );
  }
}
