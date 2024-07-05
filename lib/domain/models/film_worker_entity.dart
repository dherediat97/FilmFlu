import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_worker_entity.freezed.dart';
part 'film_worker_entity.g.dart';

@freezed
class FilmWorkerEntity with _$FilmWorkerEntity {
  const factory FilmWorkerEntity({
    required int id,
    bool? adult,
    int? gender,
    String? knownForDepartment,
    String? name,
    String? profilePath,
    String? job,
    required List<int> genreIds,
  }) = _FilmWorkerEntity;

  factory FilmWorkerEntity.fromJson(Map<String, dynamic> json) =>
      _$FilmWorkerEntityFromJson(json);
}
