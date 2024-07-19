import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor_remote_entity.freezed.dart';
part 'actor_remote_entity.g.dart';

@freezed
class ActorRemoteEntity with _$ActorRemoteEntity {
  const factory ActorRemoteEntity({
    @JsonKey(name: 'gender') required int gender,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'original_name') required String originalName,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'character') required String character,
  }) = _ActorRemoteEntity;

  factory ActorRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$ActorRemoteEntityFromJson(json);
}

extension ActorEntityToRemoteEntityExtension on ActorRemoteEntity {
  ActorEntity toActorEntity() => ActorEntity(
        id: id,
        character: character,
        name: name,
        gender: gender,
        originalName: originalName,
        profilePath: profilePath,
      );
}
