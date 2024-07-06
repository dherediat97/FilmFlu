import 'package:film_flu/app/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  static List<Interceptor>? interceptors;
  static DioClient? _instance;
  static final Dio _dio = Dio();

  factory DioClient() => _instance ?? DioClient._internal();

  DioClient._internal() {
    _instance = this;
  }

  void addInterceptors(List<Interceptor> interceptors) {
    _dio
      ..options.connectTimeout =
          const Duration(milliseconds: _defaultConnectTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: _defaultReceiveTimeout)
      ..httpClientAdapter;
    _dio.options.headers = AppConstants.baseHeaders;
    if (interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
    if (AppConstants.debugRequest && kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
        request: true,
        requestBody: true,
      ));
    }
  }

  Dio getDio() {
    return _dio;
  }
}
