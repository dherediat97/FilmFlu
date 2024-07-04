import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_entity.freezed.dart';
part 'language_entity.g.dart';

@freezed
class LanguageEntity with _$LanguageEntity {
  const factory LanguageEntity({
    required String iso639_1,
    required String englishName,
    required String name,
  }) = _LanguageEntity;

  factory LanguageEntity.fromJson(Map<String, dynamic> json) =>
      _$LanguageEntityFromJson(json);
}
