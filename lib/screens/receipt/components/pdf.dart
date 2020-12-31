import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pos_app/screens/receipt/components/pdf_viewer.dart';
import 'package:pos_app/screens/receipt/receipt_controller.dart';

Future savetoPdf() async {
  final pdf = pw.Document();
  DateTime now = DateTime.now();
  pdf.addPage(
    pw.Page(
        pageFormat: PdfPageFormat(57 * PdfPageFormat.mm, double.infinity),
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(10.0),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // pw.Icon(pw.Icons.close),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Hoa Don Thanh Toan #20123014',
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(
                          now.day.toString() +
                              ' thang ' +
                              now.month.toString() +
                              ' nam ' +
                              now.year.toString() +
                              ' ' +
                              now.hour.toString() +
                              ':' +
                              now.minute.toString(),
                          style:
                              pw.TextStyle(color: PdfColors.black, fontSize: 6),
                        )
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          'Ca Phe Panda',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 15),
                        )
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          '85 Nguyen Hue, TP Long Xuyen, AG',
                          maxLines: 2,
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          'Hotline: 0339888746',
                          maxLines: 2,
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Text(
                            '1 mon (SL: 4)',
                            maxLines: 2,
                            //style: Pallate.titleProduct(),
                          ),
                        )
                      ],
                    ),
                    pw.Divider(
                      thickness: 2,
                      color: PdfColors.blueGrey,
                    ),
                    //_contentTable(context),
                    pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pw.Text('4x', style: pw.TextStyle(fontSize: 8)),
                            pw.SizedBox(
                              width: 2,
                            ),
                            pw.Expanded(
                              child: pw.Align(
                                alignment: pw.Alignment.bottomLeft,
                                child: pw.Column(
                                  children: [
                                    pw.Text(
                                      'Ca phe',
                                      style: pw.TextStyle(
                                          fontSize: 7,
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                      '10,000 d',
                                      style: pw.TextStyle(
                                          color: PdfColors.grey, fontSize: 6),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            pw.Text('40,000 d',
                                style: pw.TextStyle(fontSize: 8))
                          ],
                        ),
                        pw.Divider(),
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Tong: 40,000 d',
                          style: pw.TextStyle(
                              color: PdfColors.blueGrey,
                              //fontWeight: FontWeight.bold,
                              fontSize: 11),
                        )
                      ],
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Nhan: 50,000 d',
                          style: pw.TextStyle(
                              color: PdfColors.blueGrey, fontSize: 10),
                        )
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Tien thua: 10,000 d',
                          style: pw.TextStyle(
                              color: PdfColors.blueGrey, fontSize: 10),
                        )
                      ],
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Divider(
                      thickness: 2,
                      color: PdfColors.blueGrey,
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          'Cam on quy khach, hen gap lai!',
                          style: pw.TextStyle(
                              color: PdfColors.blueGrey,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 7),
                        )
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Container(
                          height: 50,
                          width: 50,
                          child: pw.BarcodeWidget(
                            barcode: pw.Barcode.qrCode(),
                            data: '20123014',
                          ),
                          //child: pw.BarcodeWidget(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
  );
  var pdfUrl = await ReceiptController().write(pdf);
  print(pdfUrl);
  Get.to(PdfViewerScreen(), arguments: pdfUrl);
}

pw.Widget _contentTable(pw.Context context) {
  const tableHeaders = ['SP', 'Gia', 'SL', 'Tong'];

  return pw.Table.fromTextArray(
    border: null,
    cellAlignment: pw.Alignment.centerLeft,
    headerDecoration: pw.BoxDecoration(
      // borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
      color: PdfColors.white,
    ),
    headerHeight: 25,
    cellHeight: 40,
    cellAlignments: {
      0: pw.Alignment.centerLeft,
      1: pw.Alignment.centerLeft,
      2: pw.Alignment.centerRight,
      3: pw.Alignment.center,
      4: pw.Alignment.centerRight,
    },
    headerStyle: pw.TextStyle(
      color: PdfColors.grey,
      fontSize: 10,
      fontWeight: pw.FontWeight.bold,
    ),
    cellStyle: const pw.TextStyle(
      color: PdfColors.black,
      fontSize: 10,
    ),
    rowDecoration: pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: PdfColors.grey,
          width: .5,
        ),
      ),
    ),
    headers: List<String>.generate(
      tableHeaders.length,
      (col) => tableHeaders[col],
    ),
    data: List<List<String>>.generate(
      products.length,
      (row) => List<String>.generate(
        tableHeaders.length,
        (col) => products[row].getIndex(col),
      ),
    ),
  );
}

final products = <Product>[
  Product('abc', 3.99, 2),
  Product('abc', 15, 2),
  Product('abc', 6.95, 3),
  Product('abc', 49.99, 4),
  Product('abc', 560.03, 1),
];

class Product {
  const Product(
    this.productName,
    this.price,
    this.quantity,
  );

  final String productName;
  final double price;
  final int quantity;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return productName;
      case 1:
        return (price).toString();
      case 2:
        return quantity.toString();
      case 3:
        return (total).toString();
    }
    return '';
  }
}
