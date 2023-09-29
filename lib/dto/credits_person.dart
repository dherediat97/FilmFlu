import 'package:FilmFlu/dto/credit_person.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credits_person.g.dart';

@JsonSerializable(explicitToJson: false, fieldRename: FieldRename.snake)
class CreditsPerson {
  CreditsPerson({
    required this.cast,
    this.crew,
  });

  List<CreditPerson> cast;
  List<CreditPerson>? crew;

  factory CreditsPerson.fromJson(Map<String, dynamic> json) =>
      _$CreditsPersonFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsPersonToJson(this);
}
