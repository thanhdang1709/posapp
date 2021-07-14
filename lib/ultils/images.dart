import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUltils {
  static Future<Uint8List> compressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 500,
      minHeight: 500,
      quality: 70,
      //rotate: 90,
    );
    print(file.lengthSync());
    print(result.length);
    return result;
  }
}
