import 'package:dio/dio.dart';
import 'package:filmflu/env/env.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const baseURL = "api.themoviedb.org";

class Api {
  void getMovies(String language, int page) async {
    try {
      Dio dio = Dio();
      dio.interceptors.add(PrettyDioLogger());
      var headers = {
        'Authorization': 'Bearer ${Env.tmdbApiKey}',
        'Accept': 'application/json'
      };

      final url = Uri(
          scheme: 'https',
          host: baseURL,
          path: '3/discover/movie',
          queryParameters: {
            "include_adult": false,
            "include_video": false,
            "language": "en-US",
            "page": 1,
            "sort_by": "popularity.desc"
          }).toString();
      final responseGetMovies =
          await dio.get(url, options: Options(headers: headers));
      if (responseGetMovies.statusCode == 200) {
        debugPrint("funciono bien ${responseGetMovies.data["status"]}");
        //return responseGetMovies.data;
      } else {
        debugPrint("Fallo al obtener peliculas");
      }
    } catch (ex) {
      debugPrint("Fallo al obtener peliculas: $ex");
      //return null;
    }
    //return null;
  }
}
