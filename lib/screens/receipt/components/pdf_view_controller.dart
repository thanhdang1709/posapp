import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:get/get.dart';

class PdfViewController extends GetxController {
  var doc;
  String pdfUrl = Get.arguments;
  @override
  void onReady() async {
    super.onReady();
    doc = await PDFDocument.fromFile(File(pdfUrl));
    update();
  }
}
