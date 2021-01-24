import 'package:pos_app/ultils/http_service.dart';

class AnalyticServices extends HttpService {
  // ignore: missing_return
  Future<List> getReport({Map<String, String> body}) async {
    var response = await fetch(
      url: 'api/report/list',
      method: 'POST',
      body: body,
    );
    var result;
    print(response);
    if (response.httpCode == 200) {
      result = (response.body);
      if (result['type'] == 'RESPONSE_OK') {
        return result['data'];
      }
    } else {
      return null;
    }
  }
}
