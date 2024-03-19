import 'package:FilmFlu/modules/movies/domain/entities/credits.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_item.g.dart';

@JsonSerializable(explicitToJson: false, fieldRename: FieldRename.snake)
class MediaItem {
  MediaItem({
    this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originalLanguage,
    this.originalTitle,
    required this.popularity,
    required this.posterPath,
    this.mediaType,
    this.releaseDate,
    this.title,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.overview,
    this.runtime,
    this.credits,
    this.name,
  });

  bool? adult;
  String? backdropPath;
  List<num>? genreIds;
  int id;
  String? originalLanguage;
  String? originalTitle;
  double popularity;
  String posterPath;
  String? mediaType;
  String? releaseDate;
  String? firstAirDate;
  String? title;
  bool? video;
  double voteAverage;
  int voteCount;
  String? overview;
  int? runtime;
  Credits? credits;

  String? name;

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);
}
