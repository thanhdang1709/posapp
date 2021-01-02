import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/controllers/cart_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';

// ignore: must_be_immutable
class AddNoteScreen extends GetView<CartController> {
  TextEditingController note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (controller.note.value != '') {
      note.text = controller.note.value;
    }
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        height: 50,
        centerTitle: false,
        title: 'Ghi chú',
        actions: [
          InkWell(
            onTap: () {
              note.text = '';
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                MdiIcons.close,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                controller: note,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Thêm ghi chú đơn hàng'),
                maxLines: null,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              height: Get.height * .07,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Pallate.primaryColor)),
                //color: Colors.grey[300],
                onPressed: () {
                  controller.addNote(note.text);
                  Get.back();
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.check,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Lưu',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
