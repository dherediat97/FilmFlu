import 'package:film_flu/env/env.dart';

class AppConstants {
  static const Map<String, String> baseHeaders = <String, String>{
    'Authorization': 'Bearer ${Env.tmdbApiKey}',
    'Content-Type': 'application/json',
  };
  static const bool debugRequest = false;
  static const String trailer = 'Trailer';
  static const String teaser = 'Teaser';

  static String myGithubPage = 'https://github.com/dherediat97/FilmFlu';

  //PREFERENCES KEYS
  static const colorBlindessType = 'colorBlindessType';
  static const languageKey = 'languageCode';
  static const themeModeKey = 'isDarkMode';
}
