//Core Packages
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//My Packages
import 'package:FilmFlu/dto/credits.dart';
import 'package:FilmFlu/dto/video.dart';
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/constants.dart';

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

  Future<List<Video>> fetchTrailers(int movieId, String? language) async {
    final response = await http.Client().get(
        Uri.parse('$baseURL/movie/${movieId}/videos?language=$language'),
        headers: baseHeaders);
    return compute(parseVideos, response.body);
  }

  Future<Credits> fetchCredits(int movieId) async {
    final response = await http.Client().get(
        Uri.parse('$baseURL/movie/${movieId}/credits?language=es-ES'),
        headers: baseHeaders);
    return compute(parseCredits, response.body);
  }

  Future<List<Movie>> searchMovie(String movieSearched) async {
    final response = await http.Client().get(
        Uri.parse(
            '$baseURL/search/movie?query=${movieSearched}&include_adult=false&language=es-ES&page=1'),
        headers: baseHeaders);
    return compute(parseMovies, response.body);
  }
}
