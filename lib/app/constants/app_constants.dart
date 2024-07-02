import 'package:FilmFlu/env/env.dart';

class AppConstants {
  static const String appName = 'FilmFlu';
  static String version = '';
  static const String baseURL = 'https://api.themoviedb.org/3';

  static String appDownloadBaseUrl =
      'https://github.com/dherediat97/Filmflu/releases/download/$version/app-release.apk';
  static const Map<String, String> baseHeaders = <String, String>{
    'Authorization': 'Bearer ${Env.tmdbApiKey}',
    'Content-Type': 'application/json'
  };
  static String mediaType = '';
  static String mediaTypeId = '';
}
