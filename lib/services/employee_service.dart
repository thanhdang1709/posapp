import 'dart:io';

import 'package:pos_app/models/employee.dart';
import 'package:pos_app/ultils/http_service.dart';

class EmployeeService extends HttpService {
  // ignore: missing_return
  Future<List<EmployeeModel>> getAll() async {
    var response = await fetch(
      url: 'api/employee/list',
      method: 'GET',
    );
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return List<EmployeeModel>.from(result['data']['items'].map((e) => EmployeeModel.fromJson(e)).toList());
      }
    }
    return null;
  }

  Future addEmployee({File file, Map<String, dynamic> data}) async {
    var response = await fetch(url: 'api/employee/add', method: 'POST', images: file == null ? null : [file], body: data);
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return result['message'];
      }
    }
    return null;
  }
}
