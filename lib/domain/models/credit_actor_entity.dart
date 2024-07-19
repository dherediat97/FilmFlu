import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_actor_entity.freezed.dart';
part 'credit_actor_entity.g.dart';

@freezed
class CreditActorEntity with _$CreditActorEntity {
  const factory CreditActorEntity({
    required int id,
    String? title,
    String? originalTitle,
    String? backdropPath,
    List<int>? genreIds,
    String? overview,
    String? posterPath,
    String? originalLanguage,
    String? job,
    String? character,
    required double popularity,
  }) = _CreditActorEntity;

  factory CreditActorEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditActorEntityFromJson(json);
}
