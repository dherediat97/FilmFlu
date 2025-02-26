import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/notifiers/media_detail_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final fetchMediaProvider =
    Provider.family<Future<MediaResponseEntity>, MediaItemState>((
  ref,
  mediaItemState,
) {
  return ref.read(mediaRepositoryProvider).getMedia(
        mediaItemState.mediaType,
        mediaItemState.id,
        mediaItemState.languageName,
      );
});

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
