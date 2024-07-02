import 'package:FilmFlu/data/models/credits_person_remote_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_item_entity.freezed.dart';

@freezed
class MediaItemEntity with _$MediaItemEntity {
  const factory MediaItemEntity({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    required int id,
    String? originalLanguage,
    String? originalTitle,
    required double popularity,
    required String posterPath,
    String? mediaType,
    String? releaseDate,
    String? firstAirDate,
    String? title,
    bool? video,
    required double voteAverage,
    required int voteCount,
    String? overview,
    int? runtime,
    CreditsPersonRemoteEntity? credits,
    String? name,
  }) = _MediaItemEntity;
}
