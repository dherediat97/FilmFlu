import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:FilmFlu/dto/tv_show.dart';
import 'package:FilmFlu/env/env.dart';
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

  List<TvShow> parseTvShows(String responseBody) {
    final parsed = jsonDecode(responseBody)['results'];
    return parsed.map<TvShow>((json) => TvShow.fromJson(json)).toList();
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.Client().get(
        Uri.parse(
            'https://api.themoviedb.org/3/trending/movie/day?language=es-ES'),
        headers: {"Authorization": "Bearer ${Env.tmdbApiKey}"});

    return compute(parseMovies, response.body);
  }

  Future<List<TvShow>> fetchPopularTvShows() async {
    final response = await http.Client().get(
        Uri.parse(
            'https://api.themoviedb.org/3/trending/tv/day?language=es-ES'),
        headers: {"Authorization": "Bearer ${Env.tmdbApiKey}"});

    return compute(parseTvShows, response.body);
  }
}
