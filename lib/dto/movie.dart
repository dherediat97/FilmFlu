import 'package:FilmFlu/dto/credits.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(explicitToJson: false, fieldRename: FieldRename.snake)
class Movie {
  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originalLanguage,
    this.originalTitle,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.overview,
    this.runtime,
    this.credits,
  });

  bool? adult;
  String? backdropPath;
  List<num>? genreIds;
  int id;
  String? originalLanguage;
  String? originalTitle;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  String? overview;
  int? runtime;
  Credits? credits;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
