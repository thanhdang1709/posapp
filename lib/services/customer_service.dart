import 'dart:io';

import 'package:pos_app/contants.dart';
import 'package:pos_app/models/customer_model.dart';
import 'package:pos_app/ultils/http_service.dart';

class CustomerService extends HttpService {
  Future addProduct({File file, Map<String, dynamic> data}) async {
    var response = await fetch(url: 'api/customer/add', method: 'POST', images: file == null ? null : [file], body: data);
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['message'] == 'success') {
        return result['data'];
      }
    } else {
      return false;
    }
  }

  Future update({File file, Map<String, String> data}) async {
    var response = await fetch(url: 'api/customer/update', method: 'POST', images: file == null ? null : [file], body: data);
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['message'] == 'success') {
        return result['data'];
      }
    } else {
      return null;
    }
  }

  // ignore: missing_return
  Future<List<CustomerModel>> getAll({page: CONTANTS.PAGE, limit: CONTANTS.LIMIT}) async {
    var response = await fetch(
      url: 'api/customer/list',
      method: 'GET',
      params: {'page': page, 'limit': limit},
    );
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return List<CustomerModel>.from(result['data']['items'].map((e) => CustomerModel.fromJson(e)).toList());
      }
    }
    return null;
  }

  Future delete(id) async {
    var response = await fetch(
      url: 'api/customer/delete/$id',
      method: 'GET',
    );
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['message'] == 'success') {
        return result['id'];
      }
    } else {
      return null;
    }
  }
}
