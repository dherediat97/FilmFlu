import 'package:freezed_annotation/freezed_annotation.dart';

part 'gravatar_entity.freezed.dart';
part 'gravatar_entity.g.dart';

@freezed
class GravatarEntity with _$GravatarEntity {
  const factory GravatarEntity({required String hash}) = _GravatarEntity;

  factory GravatarEntity.fromJson(Map<String, dynamic> json) =>
      _$GravatarEntityFromJson(json);
}
