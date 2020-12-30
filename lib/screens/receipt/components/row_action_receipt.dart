// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomActionReceipt extends StatelessWidget {
  BottomActionReceipt({this.savePdf});

  final Function savePdf;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .1,
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: savePdf,
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
          Column(
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
