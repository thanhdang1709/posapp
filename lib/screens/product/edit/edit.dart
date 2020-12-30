import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/catelog_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/repositories/common.dart';
import 'package:pos_app/data/controllers/edit_product_controller.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/number.dart';
//import 'package:pos_app/widgets/drawer/drawer.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({
    Key key,
    this.product,
  }) : super(key: key);

  final ProductModel product;
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  //final picker = ImagePicker();

  EditProductController editProductController =
      Get.put(EditProductController(), permanent: false);

  ProductStore productStore = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(title: 'Sửa món', actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            editProductController.deleteProduct();
          },
        )
      ]),
      // drawer: DrawerApp(),
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
                      child: Text('Chi tiết món',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)),
                    ),
                    new DropdownSearch<CatelogModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showSelectedItem: false,
                      items: productStore.catelogies,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 0, right: 0, bottom: 0, top: 5),
                      ),
                      label: "Danh mục",
                      itemAsString: (CatelogModel catelog) => catelog.name,
                      onChanged: (v) {
                        editProductController.setCatelogId(v.id);
                      },
                      selectedItem: editProductController.catelogId.value == 0
                          ? null
                          : productStore.catelogies.firstWhere((e) =>
                              editProductController.catelogId.value == e.id),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    TextFormField(
                      controller: editProductController.stockController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Kho',
                        labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
                      ),
                    ),
                    TextFormField(
                      controller: editProductController.promoPriceController,
                      onChanged: editProductController.onChangePriceProduct,
                      decoration: InputDecoration(
                        labelText: 'Giá khuyến mãi',
                        labelStyle: GoogleFonts.roboto(color: Colors.blueGrey),
                      ),
                    ),
                    TextFormField(
                      controller: editProductController.barcodeController,
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
                      controller: editProductController.noteController,
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
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()),
                ),
                barrierDismissible: false);
            editProductController.updateProduct();
          },
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: Text(
            'Lưu',
            style: TextStyle(color: Colors.white),
          ),
          color: Pallate.primaryColor),
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
                controller: editProductController.nameProduct,
                onChanged: editProductController.onChangeNameProduct,
                decoration: InputDecoration(
                    labelText: 'Tên sản phẩm ',
                    labelStyle: GoogleFonts.roboto(color: Colors.blueGrey))),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: editProductController.priceProduct,
                onChanged: editProductController.onChangePriceProduct,
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
              editProductController.showDialogPickerColor(context);
            },
            // child: const Text(''),
            color: editProductController.currentColor.value,
            textColor:
                useWhiteForeground(editProductController.currentColor.value)
                    ? const Color(0xffffffff)
                    : const Color(0xffffffff),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: editProductController.currentColor.value,
            ),
            height: Get.height * .19,
            width: Get.height * .2,
            child: Column(
              children: [
                editProductController.imagePickerPath.value == ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        // child: Image.file(
                        //   File(editProductController.imagePickerPath.value) ??
                        //       null,
                        //   fit: BoxFit.cover,
                        //   width: double.infinity,
                        //   height: Get.height * .12,
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: BASE_DOMAIN +
                              '/' +
                              editProductController.oldImageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: Get.height * .12,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          File(editProductController.imagePickerPath.value) ??
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
                  editProductController.labelName.value ?? 'Tên sản phẩm',
                  style: TextStyle(
                      color: useWhiteForeground(
                              editProductController.currentColor.value)
                          ? const Color(0xffffffff)
                          : const Color(0xffffffff)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${$Number.numberFormat(int.tryParse(editProductController.labelPrice.value) ?? 0)} đ',
                  style: TextStyle(
                      color: useWhiteForeground(
                              editProductController.currentColor.value)
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
              editProductController.addImageModalBottomSheet(context);
            },
            child: Image.asset('assets/icons/picture.png', height: 40),
          )
        ],
      ),
    );
  }
}
