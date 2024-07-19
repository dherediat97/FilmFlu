import 'package:film_flu/domain/models/credit_actor_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_actor_remote_entity.freezed.dart';
part 'credit_actor_remote_entity.g.dart';

@freezed
class CreditActorRemoteEntity with _$CreditActorRemoteEntity {
  const factory CreditActorRemoteEntity({
    @JsonKey(name: 'backdrop_path') required String? backdropPath,
    @JsonKey(name: 'genre_ids') required List<int> genreIds,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_title') required String originalTitle,
    @JsonKey(name: 'overview') required String overview,
    @JsonKey(name: 'poster_path') required String? posterPath,
    @JsonKey(name: 'popularity') double? popularity,
    @JsonKey(name: 'release_date') required String releaseDate,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'video') required bool video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'character') required String character,
    @JsonKey(name: 'credit_id') required String creditId,
  }) = _CreditActorRemoteEntity;

  factory CreditActorRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditActorRemoteEntityFromJson(json);
}

extension CreditActorToRemoteEntityExtension on CreditActorRemoteEntity {
  CreditActorEntity toCreditActorEntity() => CreditActorEntity(
        id: id,
        popularity: popularity ?? 0.0,
        backdropPath: backdropPath ?? '',
        genreIds: genreIds,
        character: character,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        posterPath: posterPath ?? '',
        title: title,
      );
}
