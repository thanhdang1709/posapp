import 'dart:io';

import 'package:pos_app/models/kitchen_model.dart';
import 'package:pos_app/ultils/http_service.dart';

class OrderService extends HttpService {
  Future addOrder({File file, Map<String, dynamic> data}) async {
    var response = await fetch(url: 'api/order/add', method: 'POST', images: file == null ? null : [file], body: data);
    if (response.httpCode == 200) {
      var result = (response.body);
      // if (result['alert'] == 'success') {
      return result['id'];
      //}
    } else {
      return false;
    }
  }

  Future updatePayment({File file, Map<String, dynamic> data}) async {
    isShowLoading = false;
    var response = await fetch(url: 'api/order/update', method: 'POST', images: file == null ? null : [file], body: data);
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['alert'] == 'success') {
        return result;
      }
    } else {
      return 0;
    }
  }

  Future updateNote({File file, Map<String, dynamic> data}) async {
    isShowLoading = false;
    var response = await fetch(
      url: 'api/order/update/note',
      method: 'POST',
      images: file == null ? null : [file],
      body: data,
    );
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['alert'] == 'success') {
        return result;
      }
    } else {
      return 0;
    }
  }

  Future removeOrder({File file, Map<String, dynamic> data}) async {
    isShowLoading = false;
    var response = await fetch(url: 'api/order/delete/' + data['order_id'], method: 'GET', images: file == null ? null : [file]);
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['alert'] == 'success') {
        return result;
      }
    } else {
      return 0;
    }
  }

  Future getAll() async {
    var response = await fetch(
      url: 'api/order/all',
      method: 'GET',
    );
    var result;
    print(response);
    if (response.httpCode == 200) {
      result = (response.body);
      if (result['alert'] == 'success') {
        return result['data'];
      }
    } else {
      return null;
    }
  }

  Future<List<KitchenModel>> getListKitchen(int orderId) async {
    var response = await fetch(url: 'api/order/list_kitchen_order', method: 'GET', params: {'order_id': orderId});
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return List.from(result['data'].map((e) => KitchenModel.fromJson(e)).toList());
      }
    }
    return null;
  }

  Future getTrasactionAll() async {
    var response = await fetch(
      url: 'api/order/transactions',
      method: 'GET',
    );
    var result;
    print(response);
    if (response.httpCode == 200) {
      result = (response.body);
      if (result['alert'] == 'success') {
        return result['data'];
      }
    } else {
      return null;
    }
  }

  Future getOrder(id) async {
    var response = await fetch(
      url: 'api/order/detail/$id',
      method: 'GET',
    );
    var result;
    // print(response.body);
    if (response.httpCode == 200) {
      result = (response.body);
      if (result['alert'] == 'success') {
        return result['data'];
      }
    } else {
      return null;
    }
  }

  Future delete(id) async {
    var response = await fetch(
      url: 'api/order/delete/$id',
      method: 'GET',
    );
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['alert'] == 'success') {
        return result['id'];
      }
    } else {
      return null;
    }
  }
}
