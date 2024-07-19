import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_worker_entity.freezed.dart';
part 'film_worker_entity.g.dart';

@freezed
class FilmWorkerEntity with _$FilmWorkerEntity {
  const factory FilmWorkerEntity({
    required int id,
    int? gender,
    String? knownForDepartment,
    String? name,
    String? originalName,
    String? profilePath,
    String? job,
  }) = _FilmWorkerEntity;

  factory FilmWorkerEntity.fromJson(Map<String, dynamic> json) =>
      _$FilmWorkerEntityFromJson(json);
}
