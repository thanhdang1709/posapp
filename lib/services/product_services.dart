import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fma/http_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pos_app/contants.dart';
import 'package:pos_app/repositories/common.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/ultils/http_service.dart';
import 'package:pos_app/ultils/images.dart';

class ProductService extends HttpService {
  // ignore: missing_return
  var _box = GetStorage();

  Map<String, String> headers(box) {
    return {
      'Authorization': 'Bearer' + box.read('token'),
      'Content-Type': 'multipart/form-data',
    };
  }

  Future<Res> addProduct({String filepath, Map<String, String> data}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${CONTANTS.BASE_DOMAIN}/api/product/add"),
    );
    //file = compressImage(file);

    // String addimageUrl = '<domain-name>/api/imageadd';
    //   Map<String, String> headers = {
    //     'Content-Type': 'multipart/form-data',
    //   };
// var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
//       ..fields.addAll(body)
//       ..headers.addAll(headers)
//       ..files.add(await http.MultipartFile.fromPath('image', filepath));
// var response = await request.send();
//     if (response.statusCode == 201) {
//       return true;
//     } else {
//       return false;
//     }
//   }

    if (filepath != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          filepath,
          //contentType: MediaType('image', 'jpg'),
        ),
      );
    }
    request.headers.addAll(headers(_box));
    request.fields.addAll(data);

    Completer completer = new Completer<Res>();
    print(request.files.first);
    http.StreamedResponse res = await request.send().timeout(Duration(seconds: 10000), onTimeout: () async {
      completer.complete(true);
      return null;
    });
    String responseBodyString = await res.stream.bytesToString();
    dynamic resultBody;
    Res response = Res(
      httpCode: res.statusCode,
      isConnectError: false,
      isResponseError: res.statusCode != 200,
    );

    try {
      resultBody = json.decode(responseBodyString);
      response.isMap = true;
    } catch (e) {
      response.isMap = false;
      resultBody = responseBodyString;
    }

    response.body = resultBody;
    //completer.complete(await _handleResponse(response));

    return (response);
    // // return res;
    // isShowLoading = true;
    // var response = await fetch(url: 'api/product/add', method: 'POST', images: [file], body: data);
    // print(response.httpCode);
    // //return response.httpCode;
  }

  Future<int> updateProduct({int id, File file, Map<String, dynamic> data}) async {
    var response = await fetch(url: 'api/product/update/' + id.toString(), method: 'POST', images: file == null ? null : [file], body: data);
    print(response);
    return response.httpCode;
  }

  // ignore: missing_return
  Future<List> getProductAll() async {
    var response = await fetch(
      url: 'api/product/list',
      method: 'GET',
    );

    if (response.httpCode == 200) {
      if ([response.isConnectError, response.isResponseError].contains(true)) {
        return null;
      } else {
        var result = (response.body);
        if (result['type'] == 'RESPONSE_OK' && result['message'] == 'success') {
          return result['data']['items'];
        }
      }
    }
  }

  // ignore: missing_return
  Future<List> getCategoryAll() async {
    var response = await fetch(
      url: 'api/category/list',
      method: 'GET',
    );
    if (response.httpCode == 200) {
      var result = (response.body);
      if (result['message'] == 'success') {
        return result['data']['items'];
      }
    }
  }

  Future deleteProduct(id) async {
    var response = await http.get('${CONTANTS.BASE_DOMAIN}/api/product/delete/$id', headers: headers(_box));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['alert'] == 'success') {
          AppUltils().getSnackBarSuccess(message: 'Xoá menu thành công');
          // return result['data'];
        } else {
          AppUltils().getSnackBarError(message: 'Xoá menu thành công');
        }
      }
    }
  }

  Future deleteCatelog(id) async {
    var response = await http.get('${CONTANTS.BASE_DOMAIN}/api/category/delete/$id', headers: headers(_box));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['alert'] == 'success') {
          AppUltils().getSnackBarSuccess(message: 'Xoá danh mục thành công');
          // return result['data'];
        }
      }
    }
  }

  // ignore: missing_return
  Future<int> addCatelog(Map<String, String> body) async {
    var response = await fetch(url: '/api/category/add', method: 'POST', body: (body));
    if (response.httpCode == 200) {
      if (response.body.isNotEmpty) {
        var result = (response.body);
        if (result['type'] == 'RESPONSE_OK' && result['message'] == 'success') {
          AppUltils().getSnackBarSuccess(message: 'Thêm danh mục thành công');
          return result['data']['item']['id'].toInt();
        }
      }
    } else {
      AppUltils().getSnackBarError(message: 'Thêm danh mục thất bại, vui lòng thử lại');
    }
  }
}
