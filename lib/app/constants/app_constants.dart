import 'package:FilmFlu/env/env.dart';

class AppConstants {
  static const String appName = 'FilmFlu';
  static String version = '';
  static const String baseURL = 'https://api.themoviedb.org/3';
  static const String movieImgBaseURL =
      'https://image.tmdb.org/t/p/w300_and_h450_bestv2/';
  static const String movieLandscapeBaseUrl =
      'https://image.tmdb.org/t/p/original';
  static const String personImgBaseUrl =
      'https://image.tmdb.org/t/p/w600_and_h900_bestv2';
  static String appDownloadBaseUrl =
      'https://github.com/dherediat97/Filmflu/releases/download/$version/app-release.apk';
  static const Map<String, String> baseHeaders = <String, String>{
    'Authorization': 'Bearer ${Env.tmdbApiKey}',
    'Content-Type': 'application/json'
  };
}
