import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

// Handle http request
class HttpServiceCore {
  String baseUrl;
  int defaultTimeout;
  int maxTimeRetry;
  Map<String, String> defaultHeaders;
  Map<String, String> defaultBody;
  List<File> defaultFiles;

  defaultFnOnTimeout() {}
  Future interceptorRequest() async {}
  Future interceptorResponse(Response request) async => request;
  // Future

  int _currentTimeRetry = 0;

  // ignore: non_constant_identifier_names
  var POST = 'POST';
  // ignore: non_constant_identifier_names
  var GET = 'GET';
  // ignore: non_constant_identifier_names
  var PUT = 'PUT';
  // ignore: non_constant_identifier_names
  var DELETE = 'DELETE';

  Future<Response> fetch({
    String url,
    String method = 'GET',
    Map<String, dynamic> params,
    int timeout,
    Function onTimeout,
    Map<String, String> headers,
    Map<String, String> body,
    List<File> files,
  }) async {
    Uri uri = await _getUrl(url, params);
    await interceptorRequest();

    return await _handleFetch(
      method: method,
      uri: uri,
      timeout: timeout ?? defaultTimeout,
      onTimeout: onTimeout ?? defaultFnOnTimeout,
      headers: headers ?? defaultHeaders,
      body: body ?? defaultBody,
      files: files ?? defaultFiles,
    );
  }

  Future<Uri> _getUrl(String url, Map<String, dynamic> params) async {
    Uri uriParsed = Uri.tryParse(url);

    // if url is path, using base url
    if (!uriParsed.hasScheme) {
      uriParsed = Uri.tryParse(baseUrl);
      uriParsed = uriParsed.resolve(url);
    }

    uriParsed = uriParsed.replace(queryParameters: params);

    return uriParsed;
  }

  Future<Response> _handleFetch({
    String method,
    Uri uri,
    int timeout,
    Function onTimeout,
    Map<String, String> headers,
    Map<String, String> body,
    List<File> files,
  }) async {
    Completer completer = new Completer<Response>();

    try {
      var request;
      if (files != null && files.length != 0) {
        for (var file in files) {
          request = http.MultipartRequest(
            method,
            uri,
          );
          request.files.add(
            http.MultipartFile(
              'image',
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path.split("/").last,
              contentType: MediaType('image', 'jpeg'),
            ),
          );
          request.fields.addAll(body);
        }
      } else {
        request = http.Request(method, uri);
        body.addAll(defaultBody);
        request.body = json.encode(body);
      }
      //request = http.Request(method, uri);
      headers.addAll(defaultHeaders);
      request.headers.addAll(headers);
      http.StreamedResponse res = await request
          .send()
          .timeout(Duration(seconds: timeout), onTimeout: () async {
        _currentTimeRetry++;
        onTimeout();

        if (_currentTimeRetry >= maxTimeRetry) {
          _currentTimeRetry = 0;
          final response = Response(
            statusCode: null,
            body: null,
            isMap: null,
            hasError: true,
          );

          completer.complete(await _handleResponse(response));
        } else {
          var nextTimeRequest = await _handleFetch(
            method: method,
            uri: uri,
            timeout: timeout,
            onTimeout: onTimeout,
            headers: headers,
            body: body,
          );

          completer.complete(nextTimeRequest);
        }

        return null;
      });

      String responseBodyString = await res.stream.bytesToString();
      dynamic resultBody;
      Response response = Response(
        statusCode: res.statusCode,
        hasError: false,
      );

      try {
        resultBody = json.decode(responseBodyString);
        response.isMap = true;
      } catch (e) {
        response.isMap = false;
        resultBody = responseBodyString;
      }
      response.body = resultBody;
      completer.complete(await _handleResponse(response));
    } catch (e) {
      print(e);
    }
    return completer.future;
  }

  Future<Response> _handleResponse(Response response) async {
    return await interceptorResponse(response);
  }
}

class Response {
  int statusCode;
  dynamic body;
  bool hasError;
  bool isMap;

  Response({this.statusCode, this.body, this.hasError, this.isMap});
}
