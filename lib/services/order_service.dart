import 'dart:io';

import 'package:pos_app/ultils/http_service.dart';

class OrderService {
  Future addOrder({File file, Map<String, dynamic> data}) async {
    var response = await HttpService().fetch(
        url: 'api/order/add',
        method: 'POST',
        files: file == null ? null : [file],
        body: data);
    if (response.statusCode == 200) {
      var result = (response.body);
      // if (result['alert'] == 'success') {
      return result['id'];
      //}
    } else {
      return false;
    }
  }

  Future update({File file, Map<String, String> data}) async {
    var response = await HttpService().fetch(
        url: 'api/order/update',
        method: 'POST',
        files: file == null ? null : [file],
        body: data);
    if (response.statusCode == 200) {
      var result = (response.body);
      if (result['alert'] == 'success') {
        return result['data'];
      }
    } else {
      return false;
    }
  }

  Future getAll() async {
    var response = await HttpService().fetch(
      url: 'api/order/all',
      method: 'GET',
    );
    var result;
    print(response);
    if (response.statusCode == 200) {
      result = (response.body);
      if (result['alert'] == 'success') {
        return result['data'];
      }
    } else {
      return null;
    }
  }

  Future getOrder(id) async {
    var response = await HttpService().fetch(
      url: 'api/order/$id',
      method: 'GET',
    );
    var result;
    // print(response.body);
    if (response.statusCode == 200) {
      result = (response.body);
      if (result['alert'] == 'success') {
        return result['data'];
      }
    } else {
      return null;
    }
  }

  Future delete(id) async {
    var response = await HttpService().fetch(
      url: 'api/order/delete/$id',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      var result = (response.body);
      if (result['alert'] == 'success') {
        return result['id'];
      }
    } else {
      return null;
    }
  }
}
