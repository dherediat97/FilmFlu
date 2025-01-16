import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/data/models/genre_remote_entity.dart';
import 'package:film_flu/data/models/production_company_remote_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/video_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_item_remote_entity.freezed.dart';
part 'media_item_remote_entity.g.dart';

@freezed
class MediaItemRemoteEntity with _$MediaItemRemoteEntity {
  const factory MediaItemRemoteEntity({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'genres') List<GenreRemoteEntity>? genres,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    @JsonKey(name: 'production_companies')
    List<ProductionCompanyRemoteEntity>? productionCompanies,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'popularity') double? popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'media_type') String? mediaType,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'videos') Pagination<VideoEntity>? videos,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'overview') String? overview,
    @JsonKey(name: 'runtime') int? runtime,
  }) = _MediaItemRemoteEntity;

  factory MediaItemRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaItemRemoteEntityFromJson(json);
}

extension MediaItemToRemoteEntityExtension on MediaItemRemoteEntity {
  MediaItemEntity toMediaEntity() => MediaItemEntity(
        title: title ?? '',
        name: name ?? '',
        id: id,
        genreIds: genreIds,
        popularity: popularity ?? 0.0,
        posterPath: posterPath ?? '',
        voteAverage: voteAverage ?? 0,
        voteCount: voteCount ?? 0,
        backdropPath: backdropPath ?? '',
        genres: genres?.map((e) => e.toGenreEntity()).toList() ?? [],
        productionCompanies: productionCompanies
                ?.map((e) => e.toProductionCompanyEntity())
                .toList() ??
            [],
        mediaType: mediaType ?? '',
        firstAirDate: firstAirDate ?? '',
        originalLanguage: originalLanguage ?? '',
        originalTitle: originalTitle ?? '',
        overview: overview ?? '',
        releaseDate: releaseDate ?? '',
        runtime: runtime ?? 0,
        videos: videos,
      );

  MediaSimpleItemEntity toSimpleMediaEntity() => MediaSimpleItemEntity(
        title: title ?? name,
        genreIds: genreIds,
        id: id,
        posterPath: posterPath ?? '',
      );

  MediaItemEntity toMediaDayEntity() => MediaItemEntity(
        title: title ?? '',
        name: name ?? '',
        id: id,
        backdropPath: backdropPath ?? '',
        voteAverage: voteAverage ?? 0,
        firstAirDate: firstAirDate ?? '',
        releaseDate: releaseDate ?? '',
      );
}
