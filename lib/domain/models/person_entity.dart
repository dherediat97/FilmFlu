import 'package:FilmFlu/domain/models/credits_person_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_entity.freezed.dart';
part 'person_entity.g.dart';

@freezed
class PersonEntity with _$PersonEntity {
  const factory PersonEntity({
    required String name,
    required int id,
    required String birthday,
    String? deathday,
    required String placeOfBirth,
    required String biography,
    String? profilePath,
    required CreditsPersonEntity credits,
  }) = _PersonEntity;

  factory PersonEntity.fromJson(Map<String, dynamic> json) =>
      _$PersonEntityFromJson(json);
}
