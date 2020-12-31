import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReceiptController extends GetxController {
  var random = Random().nextInt(10000);
  write(pdf) async {
    final Directory directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory();
    final File file = File('${directory.path}/${random}_my_file.pdf');
    await file.writeAsBytes(await pdf.save());
    return '${directory.path}/${random}_my_file.pdf';
  }

  Future<String> read() async {
    String text;
    try {
      final Directory directory = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getApplicationSupportDirectory();
      final File file = File('${directory.path}/my_file.pdf');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }
}
