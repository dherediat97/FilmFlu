import 'package:json_annotation/json_annotation.dart';

part 'credit_person.g.dart';

@JsonSerializable(explicitToJson: false, fieldRename: FieldRename.snake)
class CreditPerson {
  CreditPerson({
    required this.id,
    this.originalTitle,
    this.backdropPath,
    this.adult,
    this.genreIds,
    this.overview,
    this.posterPath,
    this.originalLanguage,
    // required this.releaseDate,
    this.character,
    this.popularity,
  });
  int id;
  String? originalTitle;
  String? backdropPath;
  bool? adult;
  List<int>? genreIds;
  String? overview;
  String? posterPath;
  String? originalLanguage;
  // String releaseDate;
  String? character;
  double? popularity;

  factory CreditPerson.fromJson(Map<String, dynamic> json) =>
      _$CreditPersonFromJson(json);

  Map<String, dynamic> toJson() => _$CreditPersonToJson(this);
}
