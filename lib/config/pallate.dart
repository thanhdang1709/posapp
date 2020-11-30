import 'package:flutter/material.dart';

class Pallate {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.greenAccent[200], Colors.blueAccent[200]],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static final Color selectedItemColor = Colors.orange;

  static final Color unselectedItemColor = Colors.grey[200];

  static final Color iconActionColor = Colors.black54;

  static final Color textColorLight = Colors.white;
}
