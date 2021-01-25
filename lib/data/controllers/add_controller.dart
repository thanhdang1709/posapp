import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/product_services.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/ultils/color.dart';

class AddProductController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  ProductStore productStore = Get.find<ProductStore>();

  RxList<ProductModel> products = <ProductModel>[].obs;

  var pickerColor = Pallate.primaryColor.obs;
  var currentColor = Pallate.primaryColor.obs;
  var labelName = 'Tên sản phẩm'.obs;
  var labelPrice = '0'.obs;
  var imagePickerPath = ''.obs;
  RxInt catelogId = 0.obs;
  final picker = ImagePicker();
  File selectedImage;

  TextEditingController nameProduct = new TextEditingController();
  TextEditingController priceProduct = new TextEditingController();
  TextEditingController stockController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();
  TextEditingController barcodeController = new TextEditingController();
  TextEditingController promoPriceController = new TextEditingController();
  TextEditingController costController = new TextEditingController();

  onChangeNameProduct(value) {
    labelName.value = value;
  }

  onChangePriceProduct(value) {
    labelPrice.value = value;
  }

  void changeColor(Color color) {
    pickerColor.value = color;
    currentColor.value = color;
    Get.back();
  }

  setCatelogId(id) {
    print(catelogId.value);

    return catelogId.value = id;
  }

  void addProduct() async {
    if (selectedImage.isNull) {
      Get.back();
      return AppUltils().getSnackBarError(message: 'Vui lòng chọn ảnh cho món');
    }
    if (nameProduct.text == '') {
      Get.back();
      return AppUltils().getSnackBarError(message: 'Vui lòng chọn tên cho món');
    }
    if (nameProduct.text == '') {
      Get.back();
      return AppUltils().getSnackBarError(message: 'Vui lòng chọn tên cho món');
    }

    Map<String, String> data = {
      'name': nameProduct.text.toString().trim(),
      'price': priceProduct.text.toString().trim(),
      'promoprice': promoPriceController.text.toString().trim(),
      'note': noteController.text.toString().trim(),
      'barcode': barcodeController.text.toString().trim(),
      'stock': stockController.text.toString().trim(),
      'catelog_id': catelogId.toString().trim(),
      'cost': costController.text.toString().trim(),
      'color': ColorFormat.colorToString(pickerColor.value).toString().trim()
    };

    var result = await ProductService().addProduct(file: selectedImage, data: (data));
    print('end');

    await getProductAll();
    productStore.products = products;
    //Get.back();
    Get.back();
    Get.back();
    if (!result.isNull) AppUltils().getSnackBarSuccess(message: 'Thêm sản phẩm thành công');
  }

  Future getProductAll() async {
    var response = (await ProductService().getProductAll());
    // print(response);
    products.assignAll(response.map((e) => ProductModel.fromJson(e)).toList());
    //return products;
    //print(catelogies[0].name);
  }

  showDialogPickerColor(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chọn màu cho sản phẩm'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor.value,
              onColorChanged: changeColor,
            ),
          ),
        );
      },
    );
  }

  addImageModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: Image.asset(
                  'assets/icons/camera.png',
                  height: 30,
                ),
                title: new Text('Chụp ảnh'),
                onTap: () {
                  //Get.to(AddPostScreen());
                  getImage(from: ImageSource.camera);
                },
              ),
              new ListTile(
                leading: Image.asset(
                  'assets/icons/picture.png',
                  height: 30,
                ),
                title: new Text('Chọn từ thư viện'),
                onTap: () {
                  getImage(from: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage({ImageSource from}) async {
    final pickedFile = await picker.getImage(source: from, imageQuality: 100);
    if (pickedFile != null) {
      imagePickerPath.value = (pickedFile.path);
      selectedImage = File(pickedFile.path);
      Get.back();
    } else {
      print('No image selected.');
    }
  }
}
