import 'package:film_flu/data/models/media_remote_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_response_remote_entity.g.dart';
part 'media_response_remote_entity.freezed.dart';

@freezed
class MediaResponseRemoteEntity with _$MediaResponseRemoteEntity {
  const factory MediaResponseRemoteEntity({
    @JsonKey(name: 'backdrops') required List<MediaRemoteEntity>? backdrops,
    @JsonKey(name: 'logos') required List<MediaRemoteEntity>? logos,
    @JsonKey(name: 'posters') required List<MediaRemoteEntity>? posters,
    @JsonKey(name: 'id') required int id,
  }) = _MediaResponseRemoteEntity;

  factory MediaResponseRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaResponseRemoteEntityFromJson(json);
}

extension MediaResponseEntityToRemoteEntityExtension
    on MediaResponseRemoteEntity {
  MediaResponseEntity toMediaRemote() => MediaResponseEntity(
        id: id,
        backdrops: backdrops?.map((e) => e.toMediaEntity()).toList() ?? [],
        logos: logos?.map((e) => e.toMediaEntity()).toList() ?? [],
        posters: posters?.map((e) => e.toMediaEntity()).toList() ?? [],
      );
}
