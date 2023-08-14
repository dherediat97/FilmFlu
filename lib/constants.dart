import 'package:FilmFlu/env/env.dart';

String version = "0.0.1";
const String baseURL = 'https://api.themoviedb.org/3';
const String movieImgBaseURL =
    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2';
const String movieLandscapeBaseUrl = 'https://image.tmdb.org/t/p/original';
const String personImgBaseUrl =
    'https://www.themoviedb.org/t/p/w138_and_h175_face';
String appDownloadBaseUrl =
    "https://github.com/dherediat97/Filmflu/releases/download/$version/app-release.apk";
const Map<String, String>? baseHeaders = {
  'Authorization': 'Bearer ${Env.tmdbApiKey}',
  'Content-Type': 'application/json'
};
