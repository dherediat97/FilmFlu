import 'package:FilmFlu/domain/models/language_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_remote_entity.freezed.dart';
part 'language_remote_entity.g.dart';

@freezed
class LanguageRemoteEntity with _$LanguageRemoteEntity {
  const factory LanguageRemoteEntity({
    @JsonKey(name: 'iso_639_1') required String iso639_1,
    @JsonKey(name: 'english_name') required String englishName,
    @JsonKey(name: 'name') required String name,
  }) = _LanguageRemoteEntity;

  factory LanguageRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$LanguageRemoteEntityFromJson(json);
}

extension LanguageEntityToRemoteEntityExtension on LanguageRemoteEntity {
  LanguageEntity toFilmWorkerEntity() => LanguageEntity(
        name: name,
        englishName: englishName,
        iso639_1: iso639_1,
      );
}
