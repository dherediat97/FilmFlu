import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: false, fieldRename: FieldRename.snake)
class Person {
  Person({
    required this.name,
    required this.id,
    required this.birthday,
    this.deathday,
    required this.placeOfBirth,
    required this.biography,
    this.profilePath,
  });

  String name;
  int id;
  String birthday;
  String? deathday;
  String placeOfBirth;
  String biography;
  String? profilePath;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
