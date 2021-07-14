import 'package:pos_app/contants.dart';
import 'package:pos_app/models/area_model.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:pos_app/ultils/http_service.dart';

class TableService extends HttpService {
  // ignore: missing_return
  Future<List<AreaModel>> getListrea({Map<String, dynamic> body, page: CONTANTS.PAGE, limit: CONTANTS.LIMIT}) async {
    var response = await fetch(
      url: 'api/area/list',
      method: 'GET',
      params: {'page': page, 'limit': limit},
    );
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return List.from(result['data']['items'].map((e) => AreaModel.fromJson(e)).toList());
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

  Future<TableModel> updateStatus({Map<String, dynamic> body}) async {
    var response = await fetch(url: 'api/table/update', method: 'POST', body: body);
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

  Future<AreaModel> updateArea({int id, Map<String, dynamic> body}) async {
    var response = await fetch(url: 'api/area/update/$id', method: 'POST', body: body);
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

  Future<TableModel> updateTable({int id, Map<String, dynamic> body}) async {
    var response = await fetch(url: 'api/table/update/$id', method: 'POST', body: body);
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

  Future<List<TableModel>> getListTable({int limit, int offset, String ext}) async {
    var response = await fetch(url: 'api/table/list', method: 'GET', params: {
      'limit': limit,
      'offset': offset,
      'ext': ext // get list table user picker.
    });
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return List.from(result['data']['items'].map((e) => TableModel.fromJson(e)).toList());
      }
    }
    return null;
  }

  Future<int> deleteTable({int tableId}) async {
    var response = await fetch(
      url: 'api/table/delete/$tableId',
      method: 'DELETE',
    );
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return result['id'];
      }
    }
    return null;
  }

  Future<int> deleteArea({int areaId}) async {
    var response = await fetch(
      url: 'api/area/delete/$areaId',
      method: 'DELETE',
    );
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return areaId;
      }
    }
    return null;
  }
}
