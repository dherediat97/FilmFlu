import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/domain/enums/media_type.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/use_case/provider.dart';
import 'package:film_flu/presentation/notifiers/models/media_item_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
final getHomeMediaDetailProvider = FutureProvider.family<
  MediaItemDetailState,
  MediaItemState
>((ref, mediaItemState) async {
  final mediaItemResponse = await ref
      .read(mediaProvider)
      .getMediaItem(
        mediaItemState.mediaType,
        mediaItemState.id,
        '${mediaItemState.languageName}_${mediaItemState.languageName.toUpperCase()}',
      );

  return MediaItemDetailState(
    trailerIds: _getTrailers(mediaItemResponse),
    isTrailerOpened: false,
  );
});

@riverpod
final getMediaItemDetailProvider =
    FutureProvider.family<MediaItemDetailState, MediaItemState>((
      ref,
      mediaItemState,
    ) async {
      final mediaItemResponse = await ref
          .read(mediaProvider)
          .getMediaItem(
            mediaItemState.mediaType,
            mediaItemState.id,
            mediaItemState.languageName,
          );

      return MediaItemDetailState(
        title:
            mediaItemState.mediaType == MediaType.movie.name
                ? mediaItemResponse.title
                : mediaItemResponse.name,
        mediaItem: mediaItemResponse,
      );
    });

@riverpod
final getReviewsProvider =
    FutureProvider.family<List<ReviewEntity>, MediaItemState>((
      ref,
      mediaItemState,
    ) async {
      final mediaItemReviews = await ref
          .read(mediaProvider)
          .getReviews(
            mediaItemState.mediaType,
            mediaItemState.id,
            mediaItemState.languageName,
          );
      return mediaItemReviews;
    });

@riverpod
final getMediaCastProvider =
    FutureProvider.family<MediaItemDetailState, CreditsMediaState>((
      ref,
      creditsMediaState,
    ) async {
      final mediaItemCast = await ref
          .read(mediaProvider)
          .getCredits(
            creditsMediaState.mediaType,
            creditsMediaState.id,
            creditsMediaState.languageName,
          );
      return MediaItemDetailState(
        cast: mediaItemCast?.cast ?? [],
        crew: mediaItemCast?.crew ?? [],
      );
    });

List<String> _getTrailers(MediaItemEntity mediaItemEntity) {
  try {
    return mediaItemEntity.videos.results
        .where(
          (element) =>
              element.type == AppConstants.trailer ||
              element.type == AppConstants.teaser,
        )
        .map((e) => e.key)
        .toList();
  } catch (ex) {
    return [];
  }
}
