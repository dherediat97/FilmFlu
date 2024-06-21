import '../../env/env.dart';

String version = '';
const String baseURL = 'https://api.themoviedb.org/3';
const String movieImgBaseURL =
    'https://image.tmdb.org/t/p/w300_and_h450_bestv2/';
const String movieLandscapeBaseUrl = 'https://image.tmdb.org/t/p/original';
const String personImgBaseUrl =
    'https://image.tmdb.org/t/p/w600_and_h900_bestv2';
String appDownloadBaseUrl =
    'https://github.com/dherediat97/Filmflu/releases/download/$version/app-release.apk';
const Map<String, String> baseHeaders = <String, String>{
  'Authorization': 'Bearer ${Env.tmdbApiKey}',
  'Content-Type': 'application/json'
};
