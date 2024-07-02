import 'package:FilmFlu/domain/models/actor_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor_remote_entity.freezed.dart';
part 'actor_remote_entity.g.dart';

@freezed
class ActorRemoteEntity with _$ActorRemoteEntity {
  const factory ActorRemoteEntity({
    @JsonKey(name: 'adult') required bool adult,
    @JsonKey(name: 'gender') required int gender,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'character') required String character,
    @JsonKey(name: 'order') required int order,
  }) = _ActorRemoteEntity;

  factory ActorRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$ActorRemoteEntityFromJson(json);
}

extension ActorEntityToRemoteEntityExtension on ActorRemoteEntity {
  ActorEntity toActorEntity() => ActorEntity(
        id: id,
        adult: adult,
        character: character,
        name: name,
        gender: gender,
        order: order,
        profilePath: profilePath,
      );
}
