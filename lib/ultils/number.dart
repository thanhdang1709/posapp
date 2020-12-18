import 'package:intl/intl.dart';

class $Number {
  static numberFormat(int number) {
    final formatter = new NumberFormat("#,###");
    return formatter.format(number);
  }
}
