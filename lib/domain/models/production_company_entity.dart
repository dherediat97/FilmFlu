import 'package:freezed_annotation/freezed_annotation.dart';

part 'production_company_entity.freezed.dart';
part 'production_company_entity.g.dart';

@freezed
class ProductionCompanyEntity with _$ProductionCompanyEntity {
  const factory ProductionCompanyEntity({
    required int id,
    String? logoPath,
    required String name,
    required String originCountry,
  }) = _ProductionCompanyEntity;

  factory ProductionCompanyEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyEntityFromJson(json);
}
