import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/data/store/product_store.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CartController extends GetxController {
  MasterStore masterStore = Get.find<MasterStore>();
  int totalPrice;
  int totalItem;
  RxInt discount = 0.obs;
  RxInt extendRowId = 0.obs;
  RxString note = ''.obs;
  RxBool itemExtend = true.obs;
  RxList<dynamic> newCart = [].obs;
  RxList cart = [].obs;
  Map<dynamic, List<dynamic>> newMap;
  Rx<CustomerModel> selectedCustomer = CustomerModel().obs;
  Rx<TableModel> selectedTable = TableModel().obs;
  QRViewController qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Barcode');
  Barcode scanResult;
  RxBool enableQrScan = false.obs;

  @override
  void onInit() {
    super.onInit();
    reloadState();
    print(newCart);
    print('init cart controller');
  }

  onCreate() {}

  remoteItemInCart(int id) {
    masterStore.cartItem..assignAll(masterStore.cartItem.where((element) => element.id != id).toList());
    extendRowId.value = 0;
    cart = masterStore.cartItem;
    newMap = groupBy(cart, (obj) => obj.id);
    newMap.removeWhere((key, value) => key == id);
    // newCart = null;
    reloadState();
  }

  extendRow(int id) {
    extendRowId.value = id;
  }

  incrementCartItem(ProductModel product, int count) {
    for (var i = 0; i < count; i++) {
      masterStore.cartItem.add(product);
    }
    reloadState();
  }

  decrementCartItem(ProductModel product, int count) {
    for (var i = 0; i < count; i++) {
      masterStore.cartItem.removeAt(masterStore.cartItem.indexWhere((e) => e == product));
    }
    reloadState();
  }

  addToCart(ProductModel product) {
    masterStore.cartItem.add(product);
  }

  addNote(String string) {
    note.value = string;
  }

  clearCart() {
    masterStore.cartItem.clear();
    Get.back();
    reloadState();
    Get.offAllNamed('pos');
  }

  selectCustomer(CustomerModel customer) {
    selectedCustomer.value = customer;
  }

  selecteTable(TableModel table) {
    selectedTable.value = table;
  }

  reloadState() {
    cart = (masterStore.cartItem);
    newMap = groupBy(cart, (obj) => obj.id);
    newCart.clear();
    newMap.values.forEach(
      (element) {
        newCart
          ..add(
            {
              'id': element.first.id,
              'priceItem': element.first.price,
              'countItem': element.length,
              'name': element.first.name,
              'totalPrice': element.map((e) => e.price).reduce((a, b) => a + b),
              'totalItem': element.length,
            },
          );
      },
    );
    totalPrice = masterStore.cartItem.length != 0 ? masterStore.cartItem.map((element) => element.price).reduce((value, element) => value + element) - discount.value : 0;
    totalItem = cart.length;
  }

  Widget buildQrView() {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (Get.size.width < 400 || Get.size.height < 400) ? 250.0 : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 5, borderLength: 60, borderWidth: 5, cutOutSize: scanArea),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      scanResult = scanData;
      print(scanResult.code);
    });
  }
}
