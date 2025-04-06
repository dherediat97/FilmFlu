import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_token_entity.freezed.dart';
part 'request_token_entity.g.dart';

@freezed
class RequestTokenEntity with _$RequestTokenEntity {
  const factory RequestTokenEntity({
    @JsonKey(name: 'approved') required bool approved,
    @JsonKey(name: 'request_token') required String requestToken,
  }) = _RequestTokenEntity;

  factory RequestTokenEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestTokenEntityFromJson(json);
}
