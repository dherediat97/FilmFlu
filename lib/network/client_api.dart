import 'dart:convert';
import 'package:FilmFlu/dto/credits.dart';
import 'package:FilmFlu/dto/video.dart';
import 'package:FilmFlu/env/env.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:FilmFlu/dto/movie.dart';

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

class Api {
  Movie parseMovie(String responseBody) {
    final parsed = jsonDecode(responseBody);
    Movie movie = Movie.fromJson(parsed);
    return movie;
  }

  List<Movie> parseMovies(String responseBody) {
    final parsed = jsonDecode(responseBody)['results'];
    return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
  }

  Credits parseCredits(String responseBody) {
    final parsed = jsonDecode(responseBody);
    Credits credits = Credits.fromJson(parsed);
    return credits;
  }

  List<Video> parseVideos(String responseBody) {
    final parsed = jsonDecode(responseBody)["results"];
    return parsed.map<Video>((json) => Video.fromJson(json)).toList();
  }

  Future<List<Movie>> fetchPopularMovies(String trendingType) async {
    final response = await http.Client().get(
        Uri.parse('$baseURL/trending/movie/$trendingType?language=es-ES'),
        headers: baseHeaders);
    return compute(parseMovies, response.body);
  }

  Future<Movie> fetchMovie(int movieId) async {
    final response = await http.Client().get(
        Uri.parse('$baseURL/movie/${movieId}?language=es-ES'),
        headers: baseHeaders);
    return compute(parseMovie, response.body);
  }

  Future<List<Video>> fetchTrailer(int movieId) async {
    final response = await http.Client().get(
        Uri.parse('$baseURL/movie/${movieId}/videos?language=es-ES'),
        headers: baseHeaders);
    return compute(parseVideos, response.body);
  }

  Future<Credits> fetchCredits(int movieId) async {
    final response = await http.Client().get(
        Uri.parse('$baseURL/movie/${movieId}/credits?language=es-ES'),
        headers: baseHeaders);
    return compute(parseCredits, response.body);
  }
}
