import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/data/models/credits_person_remote_entity.dart';
import 'package:film_flu/domain/models/video_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_item_entity.freezed.dart';
part 'media_item_entity.g.dart';

@freezed
class MediaItemEntity with _$MediaItemEntity {
  const factory MediaItemEntity({
    bool? adult,
    String? backdropPath,
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
    bool? video,
    Pagination<VideoEntity>? videos,
    double? voteAverage,
    int? voteCount,
    String? overview,
    int? runtime,
    CreditsPersonRemoteEntity? credits,
    String? name,
  }) = _MediaItemEntity;

  factory MediaItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaItemEntityFromJson(json);
}
