import 'package:json_annotation/json_annotation.dart';

part 'actor.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Actor {
  Actor({
    this.adult,
    this.gender,
    required this.id,
    this.name,
    this.profilePath,
    this.character,
    this.order,
  });

  bool? adult;
  int? gender;
  int id;
  String? name;
  String? profilePath;
  String? character;
  int? order;

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  Map<String, dynamic> toJson() => _$ActorToJson(this);
}
