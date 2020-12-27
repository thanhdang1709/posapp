import 'dart:io';

import 'package:pos_app/ultils/http_service.dart';

class CustomerService {
  Future addProduct({File file, Map<String, String> data}) async {
    var response = await HttpService().fetch(
        url: 'api/customer/add',
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
}
