import 'package:film_flu/data/models/author_details_remote_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_remote_entity.freezed.dart';
part 'review_remote_entity.g.dart';

@freezed
class ReviewRemoteEntity with _$ReviewRemoteEntity {
  const factory ReviewRemoteEntity({
    @JsonKey(name: 'author') required String author,
    @JsonKey(name: 'author_details')
    required AuthorDetailsRemoteEntity authorDetails,
    @JsonKey(name: 'content') required String content,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'url') required String url,
  }) = _ReviewRemoteEntity;

  factory ReviewRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$ReviewRemoteEntityFromJson(json);
}

extension ReviewEntityToRemoteEntityExtension on ReviewRemoteEntity {
  ReviewEntity toReviewEntity() => ReviewEntity(
        id: id,
        author: author,
        authorDetails: authorDetails.toAuthorDetailsEntity(),
        content: content,
        createdAt: createdAt,
        updatedAt: updatedAt ?? '',
        url: url,
      );
}
