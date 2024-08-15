import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/domain/models/genre_entity.dart';
import 'package:film_flu/domain/models/production_company_entity.dart';
import 'package:film_flu/domain/models/video_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_item_entity.freezed.dart';
part 'media_item_entity.g.dart';

@freezed
class MediaItemEntity with _$MediaItemEntity {
  const factory MediaItemEntity({
    String? backdropPath,
    List<GenreEntity>? genres,
    List<ProductionCompanyEntity>? productionCompanies,
    List<int>? genreIds,
    required int id,
    String? originalLanguage,
    String? originalTitle,
    double? popularity,
    String? posterPath,
    String? mediaType,
    String? releaseDate,
    String? firstAirDate,
    String? title,
    Pagination<VideoEntity>? videos,
    double? voteAverage,
    int? voteCount,
    String? overview,
    int? runtime,
    String? name,
  }) = _MediaItemEntity;

  factory MediaItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaItemEntityFromJson(json);
}
