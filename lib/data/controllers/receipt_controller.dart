import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/screens/receipt/receipt.dart';
import 'package:pos_app/services/order_service.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pos_app/screens/receipt/components/pdf_viewer.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:tiengviet/tiengviet.dart';

class ReceiptController extends GetxController {
  RxList<dynamic> order = [].obs;
  RxInt totalOrderItem = 0.obs;
  RxInt totalOrderPrice = 0.obs;
  RxInt totalMenu = 0.obs;
  RxString orderCode = ''.obs;
  RxList<dynamic> products = [].obs;
  RxList<dynamic> newProducts = [].obs;
  @override
  onInit() async {
    super.onInit();
    await reloadState();
  }

  Future reloadState() async {
    var response = await getOrderById(Get.arguments);
    order.assign(response);
    products.assignAll(order[0].products);
    totalMenu.value = order[0].products.length;
    var newMapProducts = groupBy(products, (obj) => obj.id);
    newProducts.clear();
    newMapProducts.values.forEach(
      (element) {
        newProducts
          ..add(
            {
              'product_name': element.first.name,
              'product_price': element.first.price,
              'quantity': element.length,
            },
          );
      },
    );
    totalOrderItem.value = products.length;
    orderCode.value = order[0].orderCode;
  }

  Future<OrderModel> getOrderById(id) async {
    var result = await OrderService().getOrder(id);
    return OrderModel.fromJson(result);
  }

  List<Widget> buildRowItem() {
    List<Widget> lists = [];
    newProducts?.forEach(
      (v) {
        lists.add(
          RowItemReCeipt(
            productName: v['product_name'],
            productPrice: v['product_price'],
            quantity: v['quantity'],
          ),
        );
      },
    );
    return lists;
  }

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

  Future savetoPdf() async {
    // await reloadState();
    final pdf = pw.Document();
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
                            'Hoa Don Thanh Toan #$orderCode',
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
                            order[0].createdAt?.day.toString() +
                                ' thang ' +
                                order[0].createdAt?.month.toString() +
                                ' nam ' +
                                order[0].createdAt?.year.toString() +
                                ' ' +
                                order[0].createdAt?.hour.toString() +
                                ':' +
                                order[0].createdAt?.minute.toString(),
                            style: pw.TextStyle(
                                color: PdfColors.black, fontSize: 6),
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
                              '$totalMenu mon (SL: ${totalOrderItem.value})',
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
                          ..._buildItemReceipt(newProducts),
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
                            'Tong: ${$Number.numberFormat(order[0].totalPrice ?? 0)} d',
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
                      order[0].change != 0
                          ? pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                pw.Text(
                                  'Nhan: ${$Number.numberFormat(order[0].amountReceive ?? 0)} d',
                                  style: pw.TextStyle(
                                      color: PdfColors.blueGrey, fontSize: 10),
                                )
                              ],
                            )
                          : pw.Text(''),
                      order[0].change != 0
                          ? pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                pw.Text(
                                  'Tien thua: ${$Number.numberFormat(order[0].change ?? 0)} d',
                                  style: pw.TextStyle(
                                      color: PdfColors.blueGrey, fontSize: 10),
                                )
                              ],
                            )
                          : pw.Text(''),
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
                              data: order[0].orderCode,
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

  List<pw.Widget> _buildItemReceipt(products) {
    List<pw.Widget> lists = [];
    products?.forEach(
      (v) {
        lists.add(pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text('${v['quantity']}x', style: pw.TextStyle(fontSize: 8)),
            pw.SizedBox(
              width: 5,
            ),
            pw.Expanded(
              child: pw.Align(
                alignment: pw.Alignment.bottomLeft,
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${TiengViet.parse(v['product_name'])}',
                      style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      '${v['product_price']} d',
                      style: pw.TextStyle(color: PdfColors.grey, fontSize: 6),
                    )
                  ],
                ),
              ),
            ),
            pw.Text(
                '${$Number.numberFormat(v['quantity'] * v['product_price'])} d',
                style: pw.TextStyle(fontSize: 8))
          ],
        ));
      },
    );
    return lists;
  }
}
