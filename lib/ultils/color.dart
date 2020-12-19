import 'package:flutter/material.dart';

class ColorFormat {
  static String colorToString(Color color) {
    String colorString = color.toString(); // Color(0x12345678)
    String valueString = colorString.split('(0x')[1].split(')')[0];
    return valueString;
  }

  static Color stringToColor(String color) {
    int value = int.parse(color, radix: 16);
    return new Color(value);
  }
}
