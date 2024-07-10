import 'package:film_flu/domain/models/credits_person_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_entity.freezed.dart';
part 'person_entity.g.dart';

@freezed
class PersonEntity with _$PersonEntity {
  const factory PersonEntity({
    required String name,
    required int gender,
    required List<String> alias,
    required int id,
    String? birthday,
    String? deathday,
    String? placeOfBirth,
    String? biography,
    String? profilePath,
    CreditsPersonEntity? credits,
  }) = _PersonEntity;

  factory PersonEntity.fromJson(Map<String, dynamic> json) =>
      _$PersonEntityFromJson(json);
}
