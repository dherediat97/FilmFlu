import 'package:film_flu/env/env.dart';

class AppConstants {
  static String version = '';

  static String appDownloadBaseUrl =
      'https://github.com/dherediat97/Filmflu/releases/download/$version/app-release.apk';
  static const Map<String, String> baseHeaders = <String, String>{
    'Authorization': 'Bearer ${Env.tmdbApiKey}',
    'Content-Type': 'application/json',
  };
  static int personId = 0;
  static const bool debugRequest = false;
  static const String trailer = 'Trailer';
  static const String teaser = 'Teaser';

  static String myGithubPage = 'https://github.com/dherediat97/FilmFlu';

  //PREFERENCES KEYS
  static const languageKey = 'languageCode';
  static const themeModeKey = 'themeMode';
}
