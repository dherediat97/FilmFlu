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
    required String backdropPath,
    @Default([]) List<GenreEntity> genres,
    @Default([]) List<int> genreIds,
    List<ProductionCompanyEntity>? productionCompanies,
    required int id,
    String? originalLanguage,
    String? originalTitle,
    double? popularity,
    @Default('') String posterPath,
    String? mediaType,
    required String releaseDate,
    required String firstAirDate,
    required String title,
    @Default(Pagination(results: [])) Pagination<VideoEntity> videos,
    double? voteAverage,
    int? voteCount,
    String? overview,
    int? runtime,
    required String name,
  }) = _MediaItemEntity;

  factory MediaItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaItemEntityFromJson(json);
}
