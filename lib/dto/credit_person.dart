import 'package:json_annotation/json_annotation.dart';

part 'credit_person.g.dart';

@JsonSerializable(explicitToJson: false, fieldRename: FieldRename.snake)
class CreditPerson {
  CreditPerson(
      {required this.id,
      required this.title,
      required this.backdropPath,
      required this.posterPath,
      required this.originalLanguage,
      required this.releaseDate,
      required this.character,
      required this.mediaType});
  int id;
  String title;
  String backdropPath;
  String posterPath;
  String originalLanguage;
  String releaseDate;
  String character;
  String mediaType;

  factory CreditPerson.fromJson(Map<String, dynamic> json) =>
      _$CreditPersonFromJson(json);

  Map<String, dynamic> toJson() => _$CreditPersonToJson(this);
}
