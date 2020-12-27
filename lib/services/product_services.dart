import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pos_app/repositories/common.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/ultils/http_service.dart';

class ProductService {
  // ignore: missing_return
  var _box = GetStorage();

  Map<String, String> headers(box) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + box.read('token'),
    };
  }

  Future<int> addProduct({File file, Map<String, String> data}) async {
    // var request = http.MultipartRequest(
    //   'POST',
    //   Uri.parse("$BASE_URL/api/product/add"),
    // );
    // //file = compressImage(file);

    // if (file != null) {
    //   request.files.add(
    //     http.MultipartFile(
    //       'image',
    //       file.readAsBytes().asStream(),
    //       file.lengthSync(),
    //       filename: 'image.png',
    //       contentType: MediaType('image', 'jpeg'),
    //     ),
    //   );
    // }
    // request.headers.addAll(headers(_box));
    // request.fields.addAll(data);
    // print("request: " + request.toString());
    // var res = await request.send();
    // print("This is response:" + res.toString());
    // print(res);
    // return (res.statusCode);
    // return res;
    var response = await HttpService().fetch(
        url: 'api/product/add', method: 'POST', files: [file], body: data);
    print(response.statusCode);
    return response.statusCode;
  }

  Future<int> updateProduct({File file, Map<String, dynamic> data}) async {
    ///MultiPart request
    // var request = http.MultipartRequest(
    //   'POST',
    //   Uri.parse("$BASE_URL/product/update"),
    // );
    // //file = compressImage(file);
    // if (file != null) {
    //   request.files.add(
    //     http.MultipartFile(
    //       'image',
    //       file.readAsBytes().asStream(),
    //       file.lengthSync(),
    //       filename: 'image.png',
    //       contentType: MediaType('image', 'jpeg'),
    //     ),
    //   );
    // }
    // request.headers.addAll(headers(_box));
    // request.fields.addAll(data);
    // print("request: " + request.toString());
    // var res = await request.send();
    // print("This is response:" + res.toString());
    // print(res.statusCode);
    // return (res.statusCode);
    //return res;
    var response = await HttpService().fetch(
        url: 'api/product/update',
        method: 'POST',
        files: file == null ? null : [file],
        body: data);
    print(response);
    return response.statusCode;
  }

  // ignore: missing_return
  Future<List> getProductAll() async {
    var response = await HttpService().fetch(
      url: 'api/product/all',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      var result = (response.body);
      if (result['alert'] == 'success') {
        return result['data'];
      }
    }
  }

  // ignore: missing_return
  Future<List> getCatelogAll() async {
    var response =
        await http.get('$BASE_URL/api/catelog/all', headers: headers(_box));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['alert'] == 'success') {
          return result['data'];
        }
      }
    }
  }

  Future deleteProduct(id) async {
    var response = await http.get('$BASE_URL/api/product/delete/$id',
        headers: headers(_box));
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
    var response = await http.get('$BASE_URL/api/catelog/delete/$id',
        headers: headers(_box));
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
  Future<int> addCatelog(body) async {
    var response = await http.post('$BASE_URL/api/catelog/add',
        body: jsonEncode(body), headers: headers(_box));
    print(response.body);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['alert'] == 'success') {
          AppUltils().getSnackBarSuccess(message: 'Thêm danh mục thành công');
          return result['id'].toInt();
        }
      }
    } else {
      AppUltils().getSnackBarError(
          message: 'Thêm danh mục thất bại, vui lòng thử lại');
    }
  }
}
