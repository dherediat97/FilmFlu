import 'package:FilmFlu/domain/models/actor_entity.dart';
import 'package:FilmFlu/domain/models/film_worker_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_media_entity.freezed.dart';
part 'credits_media_entity.g.dart';

@freezed
class CreditsMediaEntity with _$CreditsMediaEntity {
  const factory CreditsMediaEntity({
    @JsonKey(name: 'cast') required List<ActorEntity> cast,
    @JsonKey(name: 'crew') required List<FilmWorkerEntity> crew,
  }) = _CreditsMediaRemoteEntity;

  factory CreditsMediaEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditsMediaEntityFromJson(json);
}
