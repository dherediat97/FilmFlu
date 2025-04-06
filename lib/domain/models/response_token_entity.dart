import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_token_entity.freezed.dart';
part 'response_token_entity.g.dart';

@freezed
class ResponseTokenEntity with _$ResponseTokenEntity {
  const factory ResponseTokenEntity({
    @JsonKey(name: 'success') required bool success,
    @JsonKey(name: 'session_id') required String sessionId,
  }) = _ResponseTokenEntity;

  factory ResponseTokenEntity.fromJson(Map<String, dynamic> json) =>
      _$ResponseTokenEntityFromJson(json);
}
