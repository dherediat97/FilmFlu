import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'response_get_movies.g.dart';

@JsonSerializable()
class ResponseGetMovies {
  List<Movie>? results;

  ResponseGetMovies(this.results);

  factory ResponseGetMovies.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetMoviesFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGetMoviesToJson(this);
}
