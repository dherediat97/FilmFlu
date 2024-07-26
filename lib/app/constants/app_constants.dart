import 'package:film_flu/env/env.dart';

class AppConstants {
  static const String appName = 'FilmFlu';
  static String version = '';

  static String appDownloadBaseUrl =
      'https://github.com/dherediat97/Filmflu/releases/download/$version/app-release.apk';
  static const Map<String, String> baseHeaders = <String, String>{
    'Authorization': 'Bearer ${Env.tmdbApiKey}',
    'Content-Type': 'application/json'
  };
  static String mediaType = '';
  static int mediaTypeId = 0;
  static int personId = 0;
  static const bool debugRequest = false;

  static String myGithubPage = 'https://github.com/dherediat97';

  //PREFERENCES KEYS
  static const languageKey = 'languageCode';
  static const themeModeKey = 'themeMode';
}
