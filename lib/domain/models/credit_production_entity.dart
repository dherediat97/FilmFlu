import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_production_entity.freezed.dart';
part 'credit_production_entity.g.dart';

@freezed
class CreditProductionEntity with _$CreditProductionEntity {
  const factory CreditProductionEntity({
    required int id,
    String? title,
    String? originalTitle,
    String? backdropPath,
    bool? adult,
    List<int>? genreIds,
    String? overview,
    String? posterPath,
    String? originalLanguage,
    String? job,
    String? character,
    required double popularity,
  }) = _CreditProductionEntity;

  factory CreditProductionEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditProductionEntityFromJson(json);
}
