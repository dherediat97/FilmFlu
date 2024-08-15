import 'package:film_flu/domain/models/media_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_response_entity.g.dart';
part 'media_response_entity.freezed.dart';

@freezed
class MediaResponseEntity with _$MediaResponseEntity {
  const factory MediaResponseEntity({
    List<MediaEntity>? backdrops,
    List<MediaEntity>? logos,
    List<MediaEntity>? posters,
    required int id,
  }) = _MediaResponseEntity;

  factory MediaResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaResponseEntityFromJson(json);
}
