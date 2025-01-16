import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_media_list.freezed.dart';
part 'data_media_list.g.dart';

@freezed
class DataMediaList with _$DataMediaList {
  const factory DataMediaList({
    required int page,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
    required List<MediaSimpleItemEntity> results,
  }) = _DataMediaList;

  factory DataMediaList.fromJson(Map<String, dynamic> json) =>
      _$DataMediaListFromJson(json);
}
