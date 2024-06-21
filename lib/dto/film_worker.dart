import 'package:json_annotation/json_annotation.dart';

part 'film_worker.g.dart';

@JsonSerializable(explicitToJson: false, fieldRename: FieldRename.snake)
class FilmWorker {
  FilmWorker({
    required this.id,
    this.adult,
    this.gender,
    this.knownForDepartment,
    this.name,
    this.profilePath,
    this.job,
  });
  int id;
  bool? adult;
  int? gender;
  String? knownForDepartment;
  String? name;
  String? profilePath;
  String? job;

  factory FilmWorker.fromJson(Map<String, dynamic> json) =>
      _$FilmWorkerFromJson(json);

  Map<String, dynamic> toJson() => _$FilmWorkerToJson(this);
}
