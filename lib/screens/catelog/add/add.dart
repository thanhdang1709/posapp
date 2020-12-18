import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_app/screens/catelog/data/add_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class AddCatelogScreen extends StatefulWidget {
  AddCatelogScreen({Key key}) : super(key: key);

  @override
  _AddCatelogScreenState createState() => _AddCatelogScreenState();
}

class _AddCatelogScreenState extends State<AddCatelogScreen> {
  TextEditingController _nameController = new TextEditingController();
  AddCatelogController controller =
      Get.put<AddCatelogController>(AddCatelogController());
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
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Tên danh mục'))),
            ),
            InkWell(
              onTap: () {
                Map data = {'name': _nameController.text};
                controller.add(data);
              },
              child: Container(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
