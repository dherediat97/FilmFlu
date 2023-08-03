import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Video {
  Video({required this.key, required this.type, required this.official});
  String key;
  String type;
  bool official;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
