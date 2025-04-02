import 'package:film_flu/domain/models/auth_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_remote_entity.freezed.dart';
part 'auth_remote_entity.g.dart';

@freezed
class AuthRemoteEntity with _$AuthRemoteEntity {
  const factory AuthRemoteEntity({
    @JsonKey(name: 'success') required bool success,
    @JsonKey(name: 'expires_at') required String expiresAt,
    @JsonKey(name: 'request_token') required String requestToken,
  }) = _AuthRemoteEntity;

  factory AuthRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthRemoteEntityFromJson(json);
}

extension AuthRemoteEntityToRemoteEntityExtension on AuthRemoteEntity {
  AuthEntity toAuthEntity() => AuthEntity(
    success: success,
    requestToken: requestToken,
    expiresAt: expiresAt,
  );
}
