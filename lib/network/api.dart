import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:filmflu/env/env.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../dto/movie.dart';

const String baseURL = "https://api.themoviedb.org";

Map<String, dynamic> baseHeaders = {
  "Authorization": 'Bearer ${Env.tmdbApiKey}',
  "Content-Type": "application/json"
};

class Api {
  final _dio = Dio();
  Api() {
    _dio.options = BaseOptions(
      baseUrl: baseURL,
      headers: baseHeaders,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    );
    initializeInterceptors();
  }

  initializeInterceptors() {
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: false,
      responseBody: true,
      responseHeader: false,
      compact: true,
    ));
  }

  List<Movie> parseMovies(String responseBody) {
    final parsed = jsonDecode(responseBody)['results'];
    return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
  }

  Future<List<Movie>> fetchMovies() async {
    final response = await http.Client().get(
        Uri.parse(
            'https://api.themoviedb.org/3/discover/movie?language=${Platform.localeName.replaceAll("_", "-")}'),
        headers: {"Authorization": "Bearer ${Env.tmdbApiKey}"});

    return compute(parseMovies, response.body);
  }
}
