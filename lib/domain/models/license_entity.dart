import 'package:freezed_annotation/freezed_annotation.dart';

part 'license_entity.freezed.dart';
part 'license_entity.g.dart';

@freezed
class LicenseEntity with _$LicenseEntity {
  const factory LicenseEntity({
    required String title,
    required String text,
  }) = _LicenseEntity;

  factory LicenseEntity.fromJson(Map<String, dynamic> json) =>
      _$LicenseEntityFromJson(json);
}
