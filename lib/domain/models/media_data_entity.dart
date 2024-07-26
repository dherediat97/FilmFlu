import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_data_entity.freezed.dart';
part 'media_data_entity.g.dart';

@freezed
class MediaDataEntity with _$MediaDataEntity {
  const factory MediaDataEntity({
    required List<MediaItemEntity> movies,
    required List<MediaItemEntity> series,
  }) = _MediaDataEntity;

  factory MediaDataEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaDataEntityFromJson(json);
}
