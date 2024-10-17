import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../extension/context_extension.dart';
import '../hive/hive_methods.dart';
import '../routes/app_routers.dart';
import '../utils/common_methods.dart';

String? token;

enum ResponseState {
  sleep,
  offline,
  loading,
  pagination,
  complete,
  error,
  unauthorized,
}

class ApiResponse {
  ResponseState state;
  dynamic data;
  ApiResponse({
    required this.state,
    required this.data,
  });
}

class ApiHelper {
  static ApiHelper? _instance;

  ApiHelper._();

  static ApiHelper get instance {
    _instance ??= ApiHelper._();

    return _instance!;
  }

  final String _serverKey = '';

  MediaType appMediaType(String path) {
    List<String> list = "${lookupMimeType(path)}".split('/');
    return MediaType(
      '${list.firstOrNull}',
      '${list.lastOrNull}',
    );
  }

  final Dio _dio = Dio()
    ..interceptors.addAll(kDebugMode
        ? [
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              compact: false,
              error: true,
              request: true,
            ),
          ]
        : []);

  Options _options(
    Map<String, String>? headers,
    bool hasToken,
  ) {
    return Options(
      contentType: 'application/json',
      followRedirects: false,
      validateStatus: (status) {
        return true;
      },
      headers: {
        'Accept': 'application/json',
        'Lang': HiveMethods.getLang(),
        if (token != null && hasToken) ...{
          'Authorization': token,
        },
        ...?headers,
      },
    );
  }

  Map<String, String> _offlineMessage() {
    return {
      'message': AppRouters.navigatorKey.currentContext!.apiTr(
        ar: "تأكد من الاتصال بالإنترنت",
        en: "Make sure you are connected to the internet",
      ),
    };
  }

  Map<String, String> _errorMessage() {
    return {
      'message': AppRouters.navigatorKey.currentContext!.apiTr(
        ar: "حدث خطأ",
        en: "An error occurred",
      ),
    };
  }

  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    void Function()? onFinish,
    void Function(int, int)? onReceiveProgress,
    bool hasToken = true,
  }) async {
    ApiResponse responseJson;
    if (await CommonMethods.hasConnection() == false) {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }

    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: _options(headers, hasToken),
        onReceiveProgress: onReceiveProgress,
      );
      responseJson = _buildResponse(response);
      Future.delayed(Duration.zero, onFinish);
    } on DioException {
      responseJson = ApiResponse(
        state: ResponseState.error,
        data: _errorMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
    } on SocketException {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    return responseJson;
  }

  Future<ApiResponse> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
    void Function()? onFinish,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    bool hasToken = true,
  }) async {
    ApiResponse responseJson;

    if (await CommonMethods.hasConnection() == false) {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    try {
      final response = await _dio.post(
        url,
        queryParameters: queryParameters,
        data: body,
        options: _options(headers, hasToken),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      responseJson = _buildResponse(response);
      Future.delayed(Duration.zero, onFinish);
    } on DioException {
      responseJson = ApiResponse(
        state: ResponseState.error,
        data: _errorMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    } on SocketException {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    return responseJson;
  }

  Future<ApiResponse> put(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
    void Function()? onFinish,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    bool hasToken = true,
  }) async {
    ApiResponse responseJson;

    if (await CommonMethods.hasConnection() == false) {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    try {
      final response = await _dio.put(
        url,
        queryParameters: queryParameters,
        data: body,
        options: _options(headers, hasToken),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      responseJson = _buildResponse(response);
      Future.delayed(Duration.zero, onFinish);
    } on DioException {
      responseJson = ApiResponse(
        state: ResponseState.error,
        data: _errorMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
    } on SocketException {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    return responseJson;
  }

  Future<ApiResponse> patch(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
    void Function()? onFinish,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    bool hasToken = true,
  }) async {
    ApiResponse responseJson;

    if (await CommonMethods.hasConnection() == false) {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    try {
      final response = await _dio.patch(
        url,
        queryParameters: queryParameters,
        data: body,
        options: _options(headers, hasToken),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      responseJson = _buildResponse(response);
      Future.delayed(Duration.zero, onFinish);
    } on DioException {
      responseJson = ApiResponse(
        state: ResponseState.error,
        data: _errorMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
    } on SocketException {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    return responseJson;
  }

  Future<ApiResponse> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
    void Function()? onFinish,
    bool hasToken = true,
  }) async {
    ApiResponse responseJson;

    if (await CommonMethods.hasConnection() == false) {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    try {
      final response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        data: body,
        options: _options(headers, hasToken),
      );
      responseJson = _buildResponse(response);
      Future.delayed(Duration.zero, onFinish);
    } on DioException {
      responseJson = ApiResponse(
        state: ResponseState.error,
        data: _errorMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
    } on SocketException {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    return responseJson;
  }

  Future<ApiResponse> download(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
    void Function()? onFinish,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    bool hasToken = true,
  }) async {
    ApiResponse responseJson;

    if (await CommonMethods.hasConnection() == false) {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    final fileName = path.basename(url);
    final savePath = await _getFilePath(fileName);
    try {
      final response = await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        data: body,
        options: _options(headers, hasToken),
        onReceiveProgress: onReceiveProgress,
      );
      responseJson = _buildResponse(response);
      Future.delayed(Duration.zero, onFinish);
    } on DioException {
      responseJson = ApiResponse(
        state: ResponseState.error,
        data: _errorMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
    } on SocketException {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    return responseJson;
  }

  ApiResponse _buildResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.complete,
          data: responseJson,
        );
      case 201:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.complete,
          data: responseJson,
        );
      case 400:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.error,
          data: responseJson,
        );
      case 401:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.unauthorized,
          data: responseJson,
        );
      case 422:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.error,
          data: responseJson,
        );
      case 403:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.error,
          data: responseJson,
        );
      case 500:
      default:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.error,
          data: responseJson,
        );
    }
  }

  Future<String> _getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await path_provider.getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName.pdf';
    return path;
  }

  Future<void> sendNotification({
    required String title,
    required String body,
    required String to,
    Map<String, dynamic>? data,
    void Function()? onFinish,
  }) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$_serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{...?data},
            'to': to,
          },
        ),
      );
      Future.delayed(Duration.zero, onFinish);
    } catch (e) {
      Future.delayed(Duration.zero, onFinish);
      log("error push notification");
    }
  }
}
