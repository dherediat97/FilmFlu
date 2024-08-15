import 'package:film_flu/domain/models/media_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_remote_entity.freezed.dart';
part 'media_remote_entity.g.dart';

@freezed
class MediaRemoteEntity with _$MediaRemoteEntity {
  const factory MediaRemoteEntity({
    @JsonKey(name: 'aspectRatio') double? aspectRatio,
    @JsonKey(name: 'height') double? height,
    @JsonKey(name: 'file_path') required String filePath,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') double? voteCount,
    @JsonKey(name: 'width') double? width,
  }) = _MediaRemoteEntity;

  factory MediaRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaRemoteEntityFromJson(json);
}

extension MediaEntityToRemoteEntityExtension on MediaRemoteEntity {
  MediaEntity toMediaEntity() => MediaEntity(
        aspectRatio: aspectRatio ?? 0,
        filePath: filePath,
        height: height ?? 0,
        voteAverage: voteAverage ?? 0,
        voteCount: voteCount ?? 0,
        width: width ?? 0,
      );
}
