import 'dart:io';

import 'package:pos_app/ultils/http_service.dart';

class EmployeeService extends HttpService {
  // ignore: missing_return
  Future<List> getAll() async {
    var response = await fetch(
      url: 'api/employee/all',
      method: 'GET',
    );
    print(response);
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['type'] == 'RESPONSE_OK') {
        return result['data'];
      }
    } else {
      return null;
    }
  }

  Future addEmployee({File file, Map<String, dynamic> data}) async {
    var response = await fetch(url: 'api/employee/add', method: 'POST', files: file == null ? null : [file], body: data);
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['type'] == 'RESPONSE_OK') {
        return result['message'];
      }
    } else {
      return false;
    }
  }
}
