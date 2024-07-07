import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_data_entity.freezed.dart';
part 'media_data_entity.g.dart';

@freezed
class MediaDataEntity with _$MediaDataEntity {
  const factory MediaDataEntity({
    required List<MediaItemEntity> fictionMovies,
    required List<MediaItemEntity> dramasMovies,
    required List<MediaItemEntity> actionMovies,
    required List<MediaItemEntity> romanceMovies,
    required List<MediaItemEntity> comedyMovies,
    required List<MediaItemEntity> suspenseMovies,
    required List<MediaItemEntity> animeSeries,
    required List<MediaItemEntity> animationSeries,
    required List<MediaItemEntity> tvShowsSeries,
    required List<MediaItemEntity> documentalSeries,
  }) = _MediaDataEntity;

  factory MediaDataEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaDataEntityFromJson(json);
}
