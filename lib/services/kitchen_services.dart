import 'package:pos_app/models/kitchen_model.dart';
import 'package:pos_app/ultils/http_service.dart';

class KitchenService extends HttpService {
  // ignore: missing_return
  Future<List<KitchenModel>> getListItem({int offset, int limit}) async {
    var response = await fetch(url: 'api/order/list_item_status', method: 'GET', params: {'offset': offset, 'limit': limit});
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

  Future<int> cook({Map<String, dynamic> body}) async {
    var response = await fetch(url: 'api/order/cook', method: 'POST', body: body);
    var result;
    if ([response.isConnectError, response.isResponseError].contains(true)) {
      return null;
    } else {
      result = (response.body);
      if (result['message'] == 'success') {
        return result['data'];
      }
    }
    return null;
  }
}
