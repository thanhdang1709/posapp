import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/screens/introduce/introduce_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    var box = new GetStorage();
    box.writeIfNull("first_visit", true);
    return Introduce();
  }
}

// =7π`123457π90-=
