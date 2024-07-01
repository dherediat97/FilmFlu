import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_worker_entity.freezed.dart';
part 'film_worker_entity.g.dart';

@freezed
class FilmWorker with _$FilmWorker {
  const factory FilmWorker({
    required int id,
    bool? adult,
    int? gender,
    String? knownForDepartment,
    String? name,
    String? profilePath,
    String? job,
  }) = _FilmWorker;

  factory FilmWorker.fromJson(Map<String, dynamic> json) =>
      _$FilmWorkerFromJson(json);
}
