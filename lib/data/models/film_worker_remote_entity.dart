import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_worker_remote_entity.freezed.dart';
part 'film_worker_remote_entity.g.dart';

@freezed
class FilmWorkerRemoteEntity with _$FilmWorkerRemoteEntity {
  const factory FilmWorkerRemoteEntity({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'adult') required bool adult,
    @JsonKey(name: 'gender') required int gender,
    @JsonKey(name: 'known_for_department') required String knownForDepartment,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'job') required String job,
  }) = _FilmWorkerRemoteEntity;

  factory FilmWorkerRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$FilmWorkerRemoteEntityFromJson(json);
}

extension FilmWorkerEntityToRemoteEntityExtension on FilmWorkerRemoteEntity {
  FilmWorkerEntity toFilmWorkerEntity() => FilmWorkerEntity(
        id: id,
        adult: adult,
        job: job,
        name: name,
        gender: gender,
        knownForDepartment: knownForDepartment,
        profilePath: profilePath,
      );
}
