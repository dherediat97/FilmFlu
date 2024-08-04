import 'package:film_flu/domain/models/production_company_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'production_company_remote_entity.freezed.dart';
part 'production_company_remote_entity.g.dart';

@freezed
class ProductionCompanyRemoteEntity with _$ProductionCompanyRemoteEntity {
  const factory ProductionCompanyRemoteEntity({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'logo_path') required String? logoPath,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'origin_country') required String originCountry,
  }) = _ProductionCompanyRemoteEntity;

  factory ProductionCompanyRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyRemoteEntityFromJson(json);
}

extension ProductionCompanyEntityToRemoteEntityExtension
    on ProductionCompanyRemoteEntity {
  ProductionCompanyEntity toProductionCompanyEntity() =>
      ProductionCompanyEntity(
        id: id,
        logoPath: logoPath ?? '',
        name: name,
        originCountry: originCountry,
      );
}
