import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fma/get_tool/get_tool.dart';
import 'package:fma/http_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/widgets/common.dart';
//import 'package:pos_app/modules/http_services.dart';

class HttpService extends HttpServiceCore {
  /* DESC: Khi "url" bạn truyền vào cho mỗi request mà không có base url, ví dụ "/api/user/delete" thì sẽ được tự động gắn base url này */
  String baseUrl = CONTANTS.BASE_DOMAIN;

  /* DESC: Thời gian chờ một request phản hồi trong trường hợp mạng yếu hoặc API xử lý chậm */
  int defaultTimeout = 30; //seconds

  /* DESC: Số lượt thử kết nối lại khi quá thời gian chờ request */
  int maxTimeRetry = 3;
  GetStorage box = GetStorage();
  /* DESC: Mỗi request tự động sẽ chèn thêm headers này, nó sẽ merge với headers bạn cấu hình trong mỗi request */
  Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + GetStorage().read('token'),
  };
  /* DESC: Mỗi request tự động sẽ chèn thêm body này, nó sẽ merge với body bạn cấu hình trong mỗi request */
  Map<String, dynamic> defaultBody = {};

  /* DESC: Sự kiện khi hết thời gian chờ phản hồi của một request */
  void defaultFnOnTimeout() {}

  /* DESC: Mỗi request sẽ chạy qua hàm này trước khi gửi, bạn có thể cấu hình lấy token gắn vào header ở đây */
  Future interceptorRequest() async {
    if (isShowLoading) {
      CommonWidget.progressIndicator();
    }
    if (box.hasData('token')) {
      defaultHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + GetStorage().read('token'),
      };
    } else {
      defaultHeaders = {'Content-Type': 'application/json'};
    }
  }

  final serverDebugTool = CONTANTS.BASE_DOMAIN.split(':')[0] + ':' + CONTANTS.BASE_DOMAIN.split(':')[1];

  bool isShowLoading = false;

  /* DESC: Xử lý dữ liệu trả về  */
  Future<Res> interceptorResponse(Res response) async {
    if (isShowLoading) {
      Get.back();
    }
    if (response.body.toString().contains('Unauthorized')) {
      GetTool().setTimeout(() {
        if (Get.isSnackbarOpen) {
          Get.back();
        }
        GetTool().notify.error(title: 'common.request_error'.tr, message: 'common.anauthorized'.tr);
        Get.toNamed('welcome');
      }, 1000);
    }

    if (response.body['code'] == 500) {
      GetTool().setTimeout(() {
        if (Get.isSnackbarOpen) {
          Get.back();
        }
        GetTool().notify.error(title: 'common.request_error'.tr, message: 'common.server_error'.tr);
      }, 10);
    }

    return response;
  }
}
