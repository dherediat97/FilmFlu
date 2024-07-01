import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_remote_entity.freezed.dart';
part 'video_remote_entity.g.dart';

@freezed
class VideoRemoteEntity with _$VideoRemoteEntity {
  const factory VideoRemoteEntity({
    @JsonKey(name: 'key') required String key,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'official') required String official,
  }) = _VideoRemoteEntity;

  factory VideoRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$VideoRemoteEntityFromJson(json);
}
