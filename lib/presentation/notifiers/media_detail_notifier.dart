import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/domain/use_case/provider.dart';
import 'package:film_flu/presentation/notifiers/models/media_item_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
final getHomeMediaDetailProvider =
    FutureProvider.family<MediaItemDetailState, MediaItemState>(
        (ref, mediaItemState) async {
  final mediaItemResponse = await ref
      .read(mediaProvider)
      .getMediaItem(mediaItemState.mediaType, mediaItemState.id, '');
  return MediaItemDetailState(
    mediaItem: mediaItemResponse,
    trailerId: _getFirstTrailerId(mediaItemResponse),
    title: mediaItemState.mediaType == MediaType.movie.name
        ? mediaItemResponse.title
        : mediaItemResponse.name,
    isTrailerOpened: false,
  );
});

@riverpod
final getMediaItemDetailProvider =
    FutureProvider.family<MediaItemDetailState, MediaItemState>(
        (ref, mediaItemState) async {
  final mediaItemResponse = await ref.read(mediaProvider).getMediaItem(
        mediaItemState.mediaType,
        mediaItemState.id,
        mediaItemState.languageName,
      );
  final mediaData = await ref.read(mediaRepositoryProvider).getMedia(
        mediaItemState.mediaType,
        mediaItemState.id,
        mediaItemState.languageName,
      );

  return MediaItemDetailState(
      mediaList: mediaData,
      title: mediaItemState.mediaType == MediaType.movie.name
          ? mediaItemResponse.title
          : mediaItemResponse.name,
      mediaItem: mediaItemResponse,
      productionCompanyImages: mediaItemResponse.productionCompanies!
          .map((e) => e.logoPath)
          .toList());
});

@riverpod
final getReviewsProvider =
    FutureProvider.family<MediaItemDetailState, MediaItemState>(
        (ref, mediaItemState) async {
  final mediaItemReviews = await ref.read(mediaProvider).getReviews(
        mediaItemState.mediaType,
        mediaItemState.id,
        mediaItemState.languageName,
      );
  return MediaItemDetailState(
    mediaItem: MediaItemEntity(),
    reviews: mediaItemReviews,
  );
});

@riverpod
final getMediaCastProvider =
    FutureProvider.family<MediaItemDetailState, CreditsMediaState>(
        (ref, creditsMediaState) async {
  final mediaItemCast = await ref.read(mediaProvider).getCredits(
        creditsMediaState.mediaType,
        creditsMediaState.id,
        creditsMediaState.languageName,
      );
  return MediaItemDetailState(
    mediaItem: MediaItemEntity(),
    cast: mediaItemCast?.cast,
    crew: mediaItemCast?.crew,
  );
});

String _getFirstTrailerId(MediaItemEntity mediaItemEntity) {
  try {
    return mediaItemEntity.videos!.results
        .firstWhere((element) =>
            element.type == AppConstants.trailer ||
            element.type == AppConstants.teaser)
        .key;
  } catch (ex) {
    return '';
  }
}
