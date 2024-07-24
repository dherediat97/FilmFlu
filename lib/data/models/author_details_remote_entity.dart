import 'package:film_flu/domain/models/author_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_details_remote_entity.freezed.dart';
part 'author_details_remote_entity.g.dart';

@freezed
class AuthorDetailsRemoteEntity with _$AuthorDetailsRemoteEntity {
  const factory AuthorDetailsRemoteEntity({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'avatar_path') String? avatarPath,
    @JsonKey(name: 'rating') int? rating,
  }) = _AuthorDetailsRemoteEntity;

  factory AuthorDetailsRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsRemoteEntityFromJson(json);
}

extension ReviewEntityToRemoteEntityExtension on AuthorDetailsRemoteEntity {
  AuthorDetailsEntity toAuthorDetailsEntity() => AuthorDetailsEntity(
        avatarPath: avatarPath ?? '',
        name: name ?? '',
        rating: rating ?? 0,
        username: username,
      );
}
