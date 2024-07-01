import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_remote_entity.freezed.dart';
part 'person_remote_entity.g.dart';

@freezed
class PersonEntity with _$PersonEntity {
  const factory PersonEntity({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'birthday') required String birthday,
    @JsonKey(name: 'deathday') required String deathday,
    @JsonKey(name: 'placeOfBirth') required String placeOfBirth,
    @JsonKey(name: 'biography') required String biography,
    @JsonKey(name: 'profilePath') required String profilePath,
  }) = _PersonEntity;

  factory PersonEntity.fromJson(Map<String, dynamic> json) =>
      _$PersonEntityFromJson(json);
}
