import 'package:FilmFlu/domain/models/actor_entity.dart';
import 'package:FilmFlu/domain/models/film_worker_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_person_entity.freezed.dart';
part 'credits_person_entity.g.dart';

@freezed
class CreditsPersonEntity with _$CreditsPersonEntity {
  const factory CreditsPersonEntity({
    required List<ActorEntity> cast,
    required List<FilmWorkerEntity> crew,
  }) = _CreditsPersonEntity;

  factory CreditsPersonEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditsPersonEntityFromJson(json);
}
