import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:pos_app/repositories/common.dart';

class FolderUploadModel {
  static String request = 'request';
  static String water = 'water';
}

class UploadService {
  GetStorage box = GetStorage();
  Future upload({
    @required List<File> files,
    @required String folder,
  }) async {
    var formFile = [];
    Future someFunc() async {
      for (File file in files) {
        formFile.add(await MultipartFile.fromFile(file.path, filename: basename(file.path)));
      }
    }

    await someFunc();
    final FormData form = FormData.fromMap({"files": formFile});

    Dio dio = Dio();
    var response = await dio.post(
      BASE_URL + '/api/media/upload',
      data: form,
      options: Options(
        headers: {
          "Authorization": box.read('token'),
          "folder": folder,
        },
      ),
    );
    List listFiles = [];
    try {
      listFiles = json.decode(response.data)['data']['file_names'];
    } catch (e) {
      print(e);
    }
    return List.from(listFiles).map((item) => item).toList();
  }
}
