import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_simple_item_entity.freezed.dart';
part 'media_simple_item_entity.g.dart';

@freezed
class MediaSimpleItemEntity with _$MediaSimpleItemEntity {
  const factory MediaSimpleItemEntity({
    List<int>? genreIds,
    required int id,
    String? posterPath,
  }) = _MediaSimpleItemEntity;

  factory MediaSimpleItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaSimpleItemEntityFromJson(json);
}
