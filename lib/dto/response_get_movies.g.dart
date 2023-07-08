// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetMovies _$ResponseGetMoviesFromJson(Map<String, dynamic> json) =>
    ResponseGetMovies(
      (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetMoviesToJson(ResponseGetMovies instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
