import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_worker_remote_entity.freezed.dart';
part 'film_worker_remote_entity.g.dart';

@freezed
class FilmWorkerRemoteEntity with _$FilmWorkerRemoteEntity {
  const factory FilmWorkerRemoteEntity({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'adult') required bool adult,
    @JsonKey(name: 'gender') required int gender,
    @JsonKey(name: 'knownForDepartment') required String knownForDepartment,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'profilePath') required String profilePath,
    @JsonKey(name: 'job') required String job,
  }) = _FilmWorkerRemoteEntity;

  factory FilmWorkerRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$FilmWorkerRemoteEntityFromJson(json);
}
