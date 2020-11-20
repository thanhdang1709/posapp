import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:introduction_screen/introduction_screen.dart';
//import 'package:pos_app/screens/introduce/introduce_screen.dart';
import 'package:pos_app/screens/welcome/onboarding_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.cyan, // navigation bar color
    statusBarColor: Colors.cyan, // status bar color
  ));
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}
