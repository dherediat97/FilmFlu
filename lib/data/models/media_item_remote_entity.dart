import 'package:FilmFlu/data/models/credits_person_remote_entity.dart';
import 'package:FilmFlu/domain/models/media_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_item_remote_entity.freezed.dart';
part 'media_item_remote_entity.g.dart';

@freezed
class MediaItemRemoteEntity with _$MediaItemRemoteEntity {
  const factory MediaItemRemoteEntity({
    @JsonKey(name: 'adult') bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'genreIds') List<int>? genreIds,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'popularity') required double popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'media_type') String? mediaType,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'first_airdate') String? firstAirDate,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'video') bool? video,
    @JsonKey(name: 'vote_average') required double? voteAverage,
    @JsonKey(name: 'vote_count') required int? voteCount,
    @JsonKey(name: 'overview') String? overview,
    @JsonKey(name: 'runtime') int? runtime,
    @JsonKey(name: 'credits') CreditsPersonRemoteEntity? credits,
    @JsonKey(name: 'name') String? name,
  }) = _MediaItemRemoteEntity;

  factory MediaItemRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaItemRemoteEntityFromJson(json);
}

extension MediaItemToRemoteEntityExtension on MediaItemRemoteEntity {
  MediaItemEntity toMediaEntity() => MediaItemEntity(
        id: id,
        popularity: popularity,
        posterPath: posterPath ?? '',
        voteAverage: voteAverage ?? 0,
        voteCount: voteCount ?? 0,
        adult: adult,
        backdropPath: backdropPath ?? '',
        credits: credits,
        genreIds: genreIds,
        mediaType: mediaType,
        firstAirDate: firstAirDate ?? '',
        name: name,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        releaseDate: releaseDate,
        runtime: runtime,
        title: title,
        video: video,
      );
}
