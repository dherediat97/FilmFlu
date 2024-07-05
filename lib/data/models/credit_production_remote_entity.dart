import 'package:film_flu/domain/models/credit_production_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_production_remote_entity.freezed.dart';
part 'credit_production_remote_entity.g.dart';

@freezed
class CreditProductionRemoteEntity with _$CreditProductionRemoteEntity {
  const factory CreditProductionRemoteEntity({
    @JsonKey(name: 'adult') required bool adult,
    @JsonKey(name: 'backdrop_path') required String? backdropPath,
    @JsonKey(name: 'genre_ids') required List<int> genreIds,
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_title') required String originalTitle,
    @JsonKey(name: 'overview') required String overview,
    @JsonKey(name: 'poster_path') required String? posterPath,
    @JsonKey(name: 'popularity') required double? popularity,
    @JsonKey(name: 'release_date') required String releaseDate,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'video') required bool video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'job') required String job,
    @JsonKey(name: 'department') required String department,
    @JsonKey(name: 'credit_id') required String creditId,
  }) = _CreditProductionRemoteEntity;

  factory CreditProductionRemoteEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditProductionRemoteEntityFromJson(json);
}

extension CreditProductionToRemoteEntityExtension
    on CreditProductionRemoteEntity {
  CreditProductionEntity toCreditProduction() => CreditProductionEntity(
        id: id,
        popularity: popularity ?? 0.0,
        adult: adult,
        backdropPath: backdropPath ?? '',
        genreIds: genreIds,
        job: job,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        posterPath: posterPath ?? '',
        title: title,
      );
}
