import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_person_entity.freezed.dart';
part 'credit_person_entity.g.dart';

@freezed
class CreditPersonEntity with _$CreditPersonEntity {
  const factory CreditPersonEntity({
    required int id,
    String? title,
    String? originalTitle,
    String? backdropPath,
    List<int>? genreIds,
    String? overview,
    String? posterPath,
    String? originalLanguage,
    String? job,
    String? character,
    required double popularity,
  }) = _CreditPersonEntity;

  factory CreditPersonEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditPersonEntityFromJson(json);
}
