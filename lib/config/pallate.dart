import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pallate {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.greenAccent[200], Colors.blueAccent[200]],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static final Color selectedItemColor = Colors.orange;

  static final Color unselectedItemColor = Colors.grey[200];

  static final Color iconActionColor = Colors.black54;

  static final Color textColorLight = Colors.white;

  static TextStyle textTitle1() =>
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle textTitle2() => TextStyle(fontSize: 18, color: Colors.white);

  static TextStyle titleProduct() => TextStyle(
        fontSize: 16,
        color: Colors.blueGrey,
        fontWeight: FontWeight.bold,
      );
  static TextStyle smallText() => GoogleFonts.roboto(
        fontSize: 14,
        color: Colors.grey,
        //fontWeight: FontWeight.bold,
      );
}