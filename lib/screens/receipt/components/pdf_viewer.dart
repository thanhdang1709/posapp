import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PdfViewerScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PdfViewerScreen> {
  // ignore: unused_field
  int _actualPageNumber = 1, _allPagesCount = 0;
  bool isSampleDoc = false;
  PdfController _pdfController;

  @override
  void initState() {
    print(Get.arguments);
    _pdfController = PdfController(
      document: PdfDocument.openFile(Get.arguments),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: PdfView(
          documentLoader: Center(child: CircularProgressIndicator()),
          pageLoader: Center(child: CircularProgressIndicator()),
          controller: _pdfController,
          onDocumentLoaded: (document) {
            setState(() {
              _actualPageNumber = 1;
              _allPagesCount = document.pagesCount;
            });
          },
          onPageChanged: (page) {
            setState(() {
              _actualPageNumber = page;
            });
          },
        ),
      );
}
