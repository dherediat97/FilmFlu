import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_simple_item_entity.freezed.dart';
part 'media_simple_item_entity.g.dart';

@freezed
class MediaSimpleItemEntity with _$MediaSimpleItemEntity {
  const factory MediaSimpleItemEntity({
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    int? id,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'title') String? title,
  }) = _MediaSimpleItemEntity;

  factory MediaSimpleItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaSimpleItemEntityFromJson(json);
}
