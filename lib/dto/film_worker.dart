import 'package:json_annotation/json_annotation.dart';

part 'film_worker.g.dart';

@JsonSerializable(explicitToJson: false, fieldRename: FieldRename.snake)
class FilmWorker {
  FilmWorker({
    this.adult,
    this.gender,
    this.knowForDepartment,
    this.name,
    this.profilePath,
    this.job,
  });

  bool? adult;
  int? gender;
  String? knowForDepartment;
  String? name;
  String? profilePath;
  String? job;

  factory FilmWorker.fromJson(Map<String, dynamic> json) =>
      _$FilmWorkerFromJson(json);

  Map<String, dynamic> toJson() => _$FilmWorkerToJson(this);
}
