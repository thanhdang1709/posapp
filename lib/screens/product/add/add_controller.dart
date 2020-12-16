import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
// final AddProductRepo repository;
// AddProductController({@required this.repository}) : assert(repository != null);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  var pickerColor = Color(0xff443a49).obs;
  var currentColor = Color(0xff443a49).obs;
  var labelName = 'Tên sản phẩm'.obs;
  var labelPrice = '0'.obs;
  var imagePickerPath = ''.obs;
  final picker = ImagePicker();

  TextEditingController nameProduct = new TextEditingController();
  TextEditingController priceProduct = new TextEditingController();

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
    final pickedFile = await picker.getImage(source: from);

    if (pickedFile != null) {
      imagePickerPath.value = (pickedFile.path);
      Get.back();
    } else {
      print('No image selected.');
    }
  }
}
