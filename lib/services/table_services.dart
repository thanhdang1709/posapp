import 'package:pos_app/models/area_model.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:pos_app/ultils/http_service.dart';

class TableService extends HttpService {
  // ignore: missing_return
  Future<List<AreaModel>> getListrea({Map<String, dynamic> body}) async {
    var response = await fetch(
      url: 'api/area/list',
      method: 'GET',
    );
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return List.from(result['data'].map((e) => AreaModel.fromJson(e)).toList());
      }
    }
    return null;
  }

  Future<AreaModel> addArea({Map<String, dynamic> body}) async {
    var response = await fetch(url: 'api/area/add', method: 'POST', body: body);
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return AreaModel.fromJson(result['data']);
      }
    }
    return null;
  }

  Future<TableModel> addTable({Map<String, dynamic> body}) async {
    var response = await fetch(url: 'api/table/add', method: 'POST', body: body);
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return TableModel.fromJson(result['data']);
      }
    }
    return null;
  }

  Future<List<TableModel>> getListTable({Map<String, dynamic> body}) async {
    var response = await fetch(
      url: 'api/table/list',
      method: 'GET',
    );
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return List.from(result['data'].map((e) => TableModel.fromJson(e)).toList());
      }
    }
    return null;
  }
}
