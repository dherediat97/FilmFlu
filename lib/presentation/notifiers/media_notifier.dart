import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final fetchReviewsProvider =
    Provider.family<Future<List<ReviewEntity>?>, MediaItemState>((
  ref,
  mediaItemState,
) {
  return ref.read(mediaRepositoryProvider).getReviews(
        MediaType.values.firstWhere(
            (mediaType) => mediaType.name == mediaItemState.mediaType),
        mediaItemState.id,
        mediaItemState.languageName,
      );
});

final fetchMediaProvider =
    Provider.family<Future<MediaResponseEntity>, MediaItemState>((
  ref,
  mediaItemState,
) {
  return ref.read(mediaRepositoryProvider).getMedia(
        MediaType.values.firstWhere(
            (mediaType) => mediaType.name == mediaItemState.mediaType),
        mediaItemState.id,
        mediaItemState.languageName,
      );
});

class MediaItemState {
  final String mediaType;
  final String id;
  final String languageName;

  const MediaItemState({
    required this.mediaType,
    required this.id,
    required this.languageName,
  });
}

class MediaListState {
  final MediaType mediaType;
  final int genreId;
  final String languageId;

  const MediaListState({
    required this.mediaType,
    required this.genreId,
    required this.languageId,
  });
}

class MediaListResponse {
  final Map<int, List<MediaSimpleItemEntity>> movieData;
  final Map<int, List<MediaSimpleItemEntity>> serieData;

  MediaListResponse copyWith({
    required Map<int, List<MediaSimpleItemEntity>> movieData,
    required Map<int, List<MediaSimpleItemEntity>> serieData,
  }) {
    return MediaListResponse(
      movieData: movieData,
      serieData: serieData,
    );
  }

  const MediaListResponse({
    required this.movieData,
    required this.serieData,
  });
}
