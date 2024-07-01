import 'package:FilmFlu/domain/models/credit_person_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_person_entity.freezed.dart';
part 'credits_person_entity.g.dart';

@freezed
class CreditsPersonEntity with _$CreditsPersonEntity {
  const factory CreditsPersonEntity({
    required List<CreditPersonEntity> cast,
    List<CreditPersonEntity>? crew,
  }) = _CreditsPersonEntity;

  factory CreditsPersonEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditsPersonEntityFromJson(json);
}
