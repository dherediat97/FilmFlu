import 'package:FilmFlu/data/models/actor_remote_entity.dart';
import 'package:FilmFlu/data/models/film_worker_remote_entity.dart';
import 'package:FilmFlu/domain/models/credits_person_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_person_remote_entity.freezed.dart';
part 'credits_person_remote_entity.g.dart';

@freezed
class CreditsPersonRemoteEntity with _$CreditsPersonRemoteEntity {
  const factory CreditsPersonRemoteEntity({
    @JsonKey(name: 'cast') List<ActorRemoteEntity>? cast,
    @JsonKey(name: 'crew') List<FilmWorkerRemoteEntity>? crew,
  }) = _CreditsPersonRemoteEntity;

  factory CreditsPersonRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditsPersonRemoteEntityFromJson(json);
}

extension CreditsPersonToRemoteEntityExtension on CreditsPersonRemoteEntity {
  CreditsPersonEntity toCreditsEntity() => CreditsPersonEntity(
        cast: cast?.map((e) => e.toActorEntity()).toList(),
        crew: crew?.map((e) => e.toFilmWorkerEntity()).toList(),
      );
}
