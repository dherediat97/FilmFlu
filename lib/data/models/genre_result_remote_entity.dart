import 'package:film_flu/data/models/genre_remote_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'genre_result_remote_entity.freezed.dart';
part 'genre_result_remote_entity.g.dart';

@freezed
class GenreResultRemoteEntity with _$GenreResultRemoteEntity {
  const factory GenreResultRemoteEntity({
    @JsonKey(name: 'genres') required List<GenreRemoteEntity> genres,
  }) = _GenreResultRemoteEntity;

  factory GenreResultRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$GenreResultRemoteEntityFromJson(json);
}
