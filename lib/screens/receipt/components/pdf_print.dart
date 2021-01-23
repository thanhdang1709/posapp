import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfPrinReviewScreen extends StatelessWidget {
  PdfPrinReviewScreen(this.pdf);
  final Uint8List pdf;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('printer')),
      body: PdfPreview(
        pageFormats: {
          'P58': PdfPageFormat(58 * PdfPageFormat.mm, double.infinity),
          'P80': PdfPageFormat(80 * PdfPageFormat.mm, double.infinity),
        },
        canChangePageFormat: false,
        //  build: (format) => _generatePdf(format, title),
        build: (format) => pdf,
      ),
    );
  }

  // Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
  //   final pdf = pw.Document();

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: format,
  //       build: (context) {
  //         return pw.Center(
  //           child: pw.Text(title),
  //         );
  //       },
  //     ),
  //   );

  //   return pdf.save();
  // }
}
