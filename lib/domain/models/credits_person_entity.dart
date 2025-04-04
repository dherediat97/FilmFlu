import 'package:film_flu/domain/models/credit_actor_entity.dart';
import 'package:film_flu/domain/models/credit_production_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_person_entity.freezed.dart';
part 'credits_person_entity.g.dart';

@freezed
class CreditsPersonEntity with _$CreditsPersonEntity {
  const factory CreditsPersonEntity({
    List<CreditActorEntity>? cast,
    List<CreditProductionEntity>? crew,
  }) = _CreditsPersonEntity;

  factory CreditsPersonEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditsPersonEntityFromJson(json);
}
