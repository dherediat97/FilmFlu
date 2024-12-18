import 'package:dio/dio.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@riverpod
Dio dio(Ref ref) => Dio()
  ..options = BaseOptions(
    baseUrl: AppUrls.baseUrl,
    connectTimeout: const Duration(seconds: 5000),
    receiveTimeout: const Duration(seconds: 5000),
    responseType: ResponseType.json,
  );
