import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class AddCatelogScreen extends StatefulWidget {
  AddCatelogScreen({Key key}) : super(key: key);

  @override
  _AddCatelogScreenState createState() => _AddCatelogScreenState();
}

class _AddCatelogScreenState extends State<AddCatelogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 40,
        title: 'Tạo danh mục',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                  child: TextFormField(
                      decoration: InputDecoration(labelText: 'Tên danh mục'))),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                'Lưu',
                style: GoogleFonts.roboto(fontSize: 25, color: Colors.white),
              )),
            )
          ],
        ),
      ),
    );
  }
}
