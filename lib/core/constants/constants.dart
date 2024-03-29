import 'package:FilmFlu/modules/movies/domain/entities/media_item.dart';
import 'package:FilmFlu/env/env.dart';

String version = "";
const String baseURL = 'https://api.themoviedb.org/3';
const String movieImgBaseURL =
    'https://image.tmdb.org/t/p/w300_and_h450_bestv2/';
const String movieLandscapeBaseUrl = 'https://image.tmdb.org/t/p/original';
const String personImgBaseUrl =
    'https://image.tmdb.org/t/p/w600_and_h900_bestv2';
String appDownloadBaseUrl =
    "https://github.com/dherediat97/Filmflu/releases/download/$version/app-release.apk";
const Map<String, String>? baseHeaders = {
  'Authorization': 'Bearer ${Env.tmdbApiKey}',
  'Content-Type': 'application/json'
};

MediaItem movieMock1 = MediaItem(
  releaseDate: "2002-20-12",
  id: 4935,
  popularity: 100,
  posterPath:
      "https://image.tmdb.org/t/p/w600_and_h900_bestv2/p8EARnEw8KPZzlZg3vkseYVMczu.jpg",
  title: "Castillo Ambulante",
  video: true,
  voteAverage: 100,
  voteCount: 10000,
  mediaType: 'movie',
);
