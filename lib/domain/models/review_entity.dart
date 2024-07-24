import 'package:film_flu/domain/models/author_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_entity.freezed.dart';
part 'review_entity.g.dart';

@freezed
class ReviewEntity with _$ReviewEntity {
  const factory ReviewEntity({
    required String author,
    required AuthorDetailsEntity authorDetails,
    required String content,
    required String createdAt,
    required String updatedAt,
    required String id,
    required String url,
  }) = _ReviewEntity;

  factory ReviewEntity.fromJson(Map<String, dynamic> json) =>
      _$ReviewEntityFromJson(json);
}
