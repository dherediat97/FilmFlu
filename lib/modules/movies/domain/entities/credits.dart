import 'package:FilmFlu/dto/actor.dart';
import 'package:FilmFlu/dto/film_worker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credits.g.dart';

@JsonSerializable(explicitToJson: false, fieldRename: FieldRename.snake)
class Credits {
  Credits({
    required this.cast,
    required this.crew,
  });

  List<Actor>? cast;
  List<FilmWorker>? crew;

  factory Credits.fromJson(Map<String, dynamic> json) =>
      _$CreditsFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsToJson(this);
}
