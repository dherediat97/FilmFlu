import 'package:film_flu/domain/models/genre_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'genre_remote_entity.freezed.dart';
part 'genre_remote_entity.g.dart';

@freezed
class GenreRemoteEntity with _$GenreRemoteEntity {
  const factory GenreRemoteEntity({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
  }) = _GenreRemoteEntity;

  factory GenreRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$GenreRemoteEntityFromJson(json);
}

extension GenreRemoteEntityToRemoteEntityExtension on GenreRemoteEntity {
  GenreEntity toGenreEntity() => GenreEntity(
        id: id,
        name: name,
      );
}
