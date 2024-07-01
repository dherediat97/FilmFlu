import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_person_remote_entity.freezed.dart';
part 'credit_person_remote_entity.g.dart';

@freezed
class CreditPersonRemoteEntity with _$CreditPersonRemoteEntity {
  const factory CreditPersonRemoteEntity({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'originalTitle') required String originalTitle,
    @JsonKey(name: 'backdropPath') required String backdropPath,
    @JsonKey(name: 'adult') required bool adult,
    @JsonKey(name: 'genreIds') required List<int> genreIds,
    @JsonKey(name: 'overview') required String overview,
    @JsonKey(name: 'posterPath') required String posterPath,
    @JsonKey(name: 'originalLanguage') required String originalLanguage,
    @JsonKey(name: 'job') required String job,
    @JsonKey(name: 'character') required String character,
    @JsonKey(name: 'popularity') required double popularity,
  }) = _CreditPersonRemoteEntity;

  factory CreditPersonRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditPersonRemoteEntityFromJson(json);
}
