import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_entity.freezed.dart';
part 'video_entity.g.dart';

@freezed
class VideoEntity with _$VideoEntity {
  const factory VideoEntity({
    required String key,
    required String type,
    required bool official,
  }) = _VideoEntity;

  factory VideoEntity.fromJson(Map<String, dynamic> json) =>
      _$VideoEntityFromJson(json);
}
