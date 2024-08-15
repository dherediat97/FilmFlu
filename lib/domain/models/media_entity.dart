import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_entity.freezed.dart';
part 'media_entity.g.dart';

@freezed
class MediaEntity with _$MediaEntity {
  const factory MediaEntity({
    required double height,
    required double width,
    double? aspectRatio,
    required String filePath,
    double? voteAverage,
    double? voteCount,
  }) = _MediaEntity;

  factory MediaEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaEntityFromJson(json);
}
