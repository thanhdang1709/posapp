import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/screens/receipt/components/pdf_view_controller.dart';

class PdfViewerScreen extends GetView<PdfViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PDFViewer(document: controller.doc),
      ),
    );
  }
}
