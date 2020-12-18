import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/screens/product/list/data/list_controller.dart';
import 'package:pos_app/services/product_services.dart';
import 'package:pos_app/ultils/app_ultils.dart';

class AddProductController extends GetxController {
// final AddProductRepo repository;
// AddProductController({@required this.repository}) : assert(repository != null);

// Dio dio = new Dio();
// FormData formdata = new FormData(); // just like JS
// formdata.add("photos", new UploadFileInfo(_image, basename(_image.path)));
// dio.post(uploadURL, data: formdata, options: Options(
// method: 'POST',
// responseType: ResponseType.PLAIN // or ResponseType.JSON
// ))
// .then((response) => print(response))
// .catchError((error) => print(error));

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  ProductStore productStore = Get.put(ProductStore());
  var pickerColor = Color(0xff443a49).obs;
  var currentColor = Color(0xff3da4ab).obs;
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
    var data = {
      'name': nameProduct.text.toString(),
      'price': priceProduct.text.toString(),
      'promoprice': promoPriceController.text.toString(),
      'note': noteController.text.toString(),
      'barcode': barcodeController.text.toString(),
      'stock': stockController.text.toString(),
      'catelog_id': catelogId.toString()
    };
    var result = await ProductService()
        .submitSubscription(file: selectedImage, data: data);
    if (!result.isNull)
      AppUltils().getSnackBarSuccess(message: 'Thêm sản phẩm thành công');
    Get.back();
    Get.back();
    productStore.products = await ListProductController().getProductAll();
    //Get.reset();
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
