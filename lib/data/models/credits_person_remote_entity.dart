import 'package:film_flu/data/models/credit_actor_remote_entity.dart';
import 'package:film_flu/data/models/credit_production_remote_entity.dart';
import 'package:film_flu/domain/models/credits_person_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_person_remote_entity.freezed.dart';
part 'credits_person_remote_entity.g.dart';

@freezed
class CreditsPersonRemoteEntity with _$CreditsPersonRemoteEntity {
  const factory CreditsPersonRemoteEntity({
    @JsonKey(name: 'cast') required List<CreditActorRemoteEntity> cast,
    @JsonKey(name: 'crew') required List<CreditProductionRemoteEntity> crew,
  }) = _CreditsPersonRemoteEntity;

  factory CreditsPersonRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditsPersonRemoteEntityFromJson(json);
}

extension CreditsPersonToRemoteEntityExtension on CreditsPersonRemoteEntity {
  CreditsPersonEntity toCreditsPersonEntity() => CreditsPersonEntity(
        cast: cast.map((e) => e.toCreditActorEntity()).toList(),
        crew: crew.map((e) => e.toCreditProduction()).toList(),
      );
}
