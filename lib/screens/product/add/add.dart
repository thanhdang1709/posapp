import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/screens/product/add/add_controller.dart';
import 'package:pos_app/screens/product/list/data/list_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  //final picker = ImagePicker();

  AddProductController addProductController =
      Get.put(AddProductController(), permanent: false);
  ListProductController listProductController =
      Get.put(ListProductController(), permanent: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(title: 'Thêm sản phẩm'),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => buildContainer(context),
            ),
            buildNamePrice(),
            Divider(
              height: 5,
              thickness: 5,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Chi tiết sản phẩm',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)),
                    ),
                    new DropdownSearch<CatelogModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showSelectedItem: false,
                      items: listProductController.catelogies,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 0, right: 0, bottom: 0, top: 5),
                      ),
                      label: "Danh mục",
                      itemAsString: (CatelogModel catelog) => catelog.name,
                      onChanged: (v) {
                        addProductController.setCatelogId(v.id);
                      },
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    TextFormField(
                      controller: addProductController.stockController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Kho',
                        labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
                      ),
                    ),
                    TextFormField(
                      controller: addProductController.promoPriceController,
                      onChanged: addProductController.onChangePriceProduct,
                      decoration: InputDecoration(
                        labelText: 'Giá khuyến mãi',
                        labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
                      ),
                    ),
                    TextFormField(
                      controller: addProductController.barcodeController,
                      decoration: InputDecoration(
                          labelText: 'Code',
                          labelStyle:
                              GoogleFonts.roboto(color: Colors.blueGrey),
                          suffixIcon: Icon(
                            Mdi.barcode,
                            size: 40,
                          )),
                    ),
                    TextFormField(
                      controller: addProductController.noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Mô tả',
                        labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
                        // suffixIcon: Icon(
                        //   FontAwesome.sticky_note,
                        // ),
                      ),
                    ),
                    SizedBox(height: Get.height * .2)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FlatButton.icon(
        //shape: ShapeBorder(),
        onPressed: () {
          Get.dialog(
              Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              ),
              barrierDismissible: false);
          addProductController.addProduct();
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'Lưu',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.cyan,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Container buildNamePrice() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
                controller: addProductController.nameProduct,
                onChanged: addProductController.onChangeNameProduct,
                decoration: InputDecoration(
                    labelText: 'Tên sản phẩm ',
                    labelStyle: GoogleFonts.roboto(color: Colors.blueGrey))),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: addProductController.priceProduct,
                onChanged: addProductController.onChangePriceProduct,
                decoration: InputDecoration(
                    labelText: 'Giá bán',
                    labelStyle: GoogleFonts.roboto(color: Colors.blueGrey)))
          ],
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      height: Get.height * .21,
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0)),
            minWidth: 10,
            padding: EdgeInsets.zero,
            label: Text(''),
            icon: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(Icons.colorize_sharp),
            ),
            onPressed: () {
              addProductController.showDialogPickerColor(context);
            },
            // child: const Text(''),
            color: addProductController.currentColor.value,
            textColor:
                useWhiteForeground(addProductController.currentColor.value)
                    ? const Color(0xffffffff)
                    : const Color(0xffffffff),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: addProductController.currentColor.value,
            ),
            height: Get.height * .19,
            width: Get.height * .2,
            child: Column(
              children: [
                addProductController.imagePickerPath.value == ''
                    ? Container(
                        width: double.infinity,
                        height: Get.height * .12,
                        // decoration: BoxDecoration(border: Border(bottom: BorderSide.)),
                        child: Center(
                          child: Text(
                            addProductController.labelName.value,
                            style: TextStyle(
                                color: useWhiteForeground(
                                        addProductController.currentColor.value)
                                    ? const Color(0xffffffff)
                                    : const Color(0xffffffff)),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          File(addProductController.imagePickerPath.value) ??
                              null,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: Get.height * .12,
                        ),
                      ),
                //  Divider(color: Colors.,),
                SizedBox(
                  height: 5,
                ),
                Text(
                  addProductController.labelName.value ?? 'Tên sản phẩm',
                  style: TextStyle(
                      color: useWhiteForeground(
                              addProductController.currentColor.value)
                          ? const Color(0xffffffff)
                          : const Color(0xffffffff)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${$Number.numberFormat(int.tryParse(addProductController.labelPrice.value) ?? 0)} đ',
                  style: TextStyle(
                      color: useWhiteForeground(
                              addProductController.currentColor.value)
                          ? const Color(0xffffffff)
                          : const Color(0xffffffff)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              addProductController.addImageModalBottomSheet(context);
            },
            child: Image.asset('assets/icons/picture.png', height: 40),
          )
        ],
      ),
    );
  }
}
