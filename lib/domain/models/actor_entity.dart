import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor_entity.freezed.dart';
part 'actor_entity.g.dart';

@freezed
class ActorEntity with _$ActorEntity {
  const factory ActorEntity({
    bool? adult,
    int? gender,
    required int id,
    String? name,
    String? profilePath,
    String? character,
    int? order,
    required List<int> genreIds,
  }) = _ActorEntity;

  factory ActorEntity.fromJson(Map<String, dynamic> json) =>
      _$ActorEntityFromJson(json);
}
