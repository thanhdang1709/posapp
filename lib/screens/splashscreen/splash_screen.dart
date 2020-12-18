import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pos_app/screens/splashscreen/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Splash Screen'),
        ),
      ),
    );
  }
}
