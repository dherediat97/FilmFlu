import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_details_entity.freezed.dart';
part 'author_details_entity.g.dart';

@freezed
class AuthorDetailsEntity with _$AuthorDetailsEntity {
  const factory AuthorDetailsEntity({
    String? name,
    required String username,
    required String avatarPath,
    int? rating,
  }) = _AuthorDetailsEntity;

  factory AuthorDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsEntityFromJson(json);
}
