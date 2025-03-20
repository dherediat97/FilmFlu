import 'package:dio/dio.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/env/env.dart';

class DioClient {
  DioClient._();

  static final instance = DioClient._();

  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'Authorization': 'Bearer ${Env.tmdbApiKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      baseUrl: AppUrls.baseUrl,
      connectTimeout: const Duration(seconds: 5000),
      receiveTimeout: const Duration(seconds: 5000),
      responseType: ResponseType.json,
    ),
  );

  //Request Method
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Object? data,
    HttpMethod? httpMethod = HttpMethod.getRequest,
  }) async {
    try {
      final Response response = switch (httpMethod) {
        HttpMethod.getRequest => await _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ),
        HttpMethod.postRequest => await _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
        HttpMethod.putRequest => await _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
        HttpMethod.deleteRequest => await _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        _ => throw 'Invalid http method',
      };
      if (response.statusCode == 200) {
        return response.data;
      }
      throw 'something went wrong';
    } catch (e) {
      rethrow;
    }
  }
}

enum HttpMethod { getRequest, postRequest, putRequest, deleteRequest }
