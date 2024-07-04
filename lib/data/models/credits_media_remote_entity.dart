import 'package:FilmFlu/app/extensions/custom_loading.dart';
import 'package:FilmFlu/data/models/actor_remote_entity.dart';
import 'package:FilmFlu/data/models/film_worker_remote_entity.dart';
import 'package:FilmFlu/domain/models/credits_media_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_media_remote_entity.freezed.dart';
part 'credits_media_remote_entity.g.dart';

@freezed
class CreditsMediaRemoteEntity with _$CreditsMediaRemoteEntity {
  const factory CreditsMediaRemoteEntity({
    @JsonKey(name: 'cast') required Set<ActorRemoteEntity> cast,
    @JsonKey(name: 'crew') required Set<FilmWorkerRemoteEntity> crew,
  }) = _CreditsMediaRemoteEntity;

  factory CreditsMediaRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditsMediaRemoteEntityFromJson(json);
}

extension CreditsPersonToRemoteEntityExtension on CreditsMediaRemoteEntity {
  CreditsMediaEntity toCreditsEntity() => CreditsMediaEntity(
        cast: cast
            .map((e) => e.toActorEntity())
            .toList()
            .unique((element) => element.name),
        crew: crew
            .map((e) => e.toFilmWorkerEntity())
            .toList()
            .unique((element) => element.name),
      );
}
