import 'package:pos_app/ultils/http_service.dart';

class AuthService extends HttpService {
  // ignore: missing_return
  Future login({Map<String, dynamic> body}) async {
    var response = await fetch(
      url: '/api/login',
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
