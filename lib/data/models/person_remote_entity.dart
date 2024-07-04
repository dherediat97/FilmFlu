import 'package:FilmFlu/data/models/credits_person_remote_entity.dart';
import 'package:FilmFlu/domain/models/person_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_remote_entity.freezed.dart';
part 'person_remote_entity.g.dart';

@freezed
class PersonRemoteEntity with _$PersonRemoteEntity {
  const factory PersonRemoteEntity({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'birthday') String? birthday,
    @JsonKey(name: 'deathday') String? deathday,
    @JsonKey(name: 'place_of_birth') String? placeOfBirth,
    @JsonKey(name: 'biography') String? biography,
    @JsonKey(name: 'profile_path') required String profilePath,
    @JsonKey(name: 'credits') required CreditsPersonRemoteEntity credits,
  }) = _PersonRemoteEntity;

  factory PersonRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$PersonRemoteEntityFromJson(json);
}

extension MediaItemToRemoteEntityExtension on PersonRemoteEntity {
  PersonEntity toPersonEntity() => PersonEntity(
        id: id,
        name: name,
        biography: biography ?? '',
        birthday: birthday ?? '',
        placeOfBirth: placeOfBirth ?? '',
        deathday: deathday ?? '',
        profilePath: profilePath,
        credits: credits.toCreditsPersonEntity(),
      );
}
