// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/data/controllers/receipt_controller.dart';
import 'package:pos_app/screens/receipt/components/pdf.dart';
import 'package:pos_app/widgets/common/dialog.dart';

class BottomActionReceipt extends StatelessWidget {
  //BottomActionReceipt({this.savePdf});

  //Function savePdf;
  @override
  Widget build(BuildContext context) {
    ReceiptController receiptController = Get.put(ReceiptController());
    return Container(
      height: Get.height * .1,
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              // ignore: unnecessary_statements
              await receiptController.savetoPdf();
            },
            // onTap: () async {
            //   // // ignore: unnecessary_statements
            //   var bytes = await generateInvoice(PdfPageFormat.legal);
            //   ReceiptController().write(bytes);
            // },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.picture_as_pdf,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Lưu PDF',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.send,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          InkWell(
            onTap: () {
              DialogConfirm()
                  .info(
                    context: context,
                    title: "Thông báo",
                    desc: "Không tìm thấy máy in",
                  )
                  .onCancel(
                    text: "Đóng lại",
                  )
                  .onConfirm(
                    text: "Cài đặt",
                    onPress: () {
                      print('onConfirm');
                    },
                  )
                  .show(hideIcon: false);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.print,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'In',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.share,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Chia sẻ',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
