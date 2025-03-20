import 'package:film_flu/domain/enums/media_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_entity.freezed.dart';
part 'search_result_entity.g.dart';

@freezed
class SearchResultEntity with _$SearchResultEntity {
  const factory SearchResultEntity({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'original_name') String? originalName,
    @JsonKey(name: 'media_type') required MediaType mediaType,
    @JsonKey(name: 'adult') bool? adult,
    @JsonKey(name: 'popularity') double? popularity,
    @JsonKey(name: 'gender') int? gender,
    @JsonKey(name: 'known_for_department') String? knownForDepartment,
    @JsonKey(name: 'profile_path') String? profilePath,
    // @JsonKey(name: 'known_for') List<MediaItemEntity>? knownFor,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'overview') String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'video') bool? video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'origin_country') List<String>? originCountry,
  }) = _SearchResultEntity;

  factory SearchResultEntity.fromJson(Map<String, dynamic> json) =>
      _$SearchResultEntityFromJson(json);
}
