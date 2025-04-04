import 'package:film_flu/domain/models/credits_person_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_entity.freezed.dart';
part 'person_entity.g.dart';

@freezed
class PersonEntity with _$PersonEntity {
  const factory PersonEntity({
    required String name,
    required int gender,
    @Default([]) List<String> alias,
    required int id,
    required String birthday,
    @Default('') String deathday,
    @Default('') String placeOfBirth,
    @Default('') String biography,
    @Default('') String profilePath,
    CreditsPersonEntity? credits,
  }) = _PersonEntity;

  factory PersonEntity.fromJson(Map<String, dynamic> json) =>
      _$PersonEntityFromJson(json);
}
