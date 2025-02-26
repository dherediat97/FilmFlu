import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/use_case/provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_detail_notifier.freezed.dart';

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

  return MediaItemDetailState(
    title: mediaItemState.mediaType == MediaType.movie.name
        ? mediaItemResponse.title
        : mediaItemResponse.name,
    mediaItem: mediaItemResponse,
    productionCompanyImage: mediaItemResponse.productionCompanies!.isNotEmpty
        ? mediaItemResponse.productionCompanies!.first.logoPath
        : '',
  );
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
    cast: creditsMediaState.isCast ? mediaItemCast?.cast : [],
    crew: !creditsMediaState.isCast ? mediaItemCast?.crew : [],
  );
});

String _getFirstTrailerId(MediaItemEntity mediaItemEntity) {
  try {
    return mediaItemEntity.videos!.results
        .firstWhere((element) =>
            element.type == AppConstants.trailer ||
            element.type == AppConstants.teaser)
        .key
        .toString();
  } catch (ex) {
    return '';
  }
}

@freezed
class MediaItemDetailState with _$MediaItemDetailState {
  const factory MediaItemDetailState({
    MediaItemEntity? mediaItem,
    String? title,
    String? trailerId,
    String? productionCompanyImage,
    List<ReviewEntity>? reviews,
    List<ActorEntity>? cast,
    List<FilmWorkerEntity>? crew,
    MediaResponseEntity? mediaList,
    bool? isTrailerOpened,
  }) = _MediaItemDetailState;
}

@freezed
class CreditsMediaState with _$CreditsMediaState {
  const factory CreditsMediaState({
    required String mediaType,
    required String id,
    required String languageName,
    required bool isCast,
  }) = _CreditsMediaState;
}

@freezed
class MediaItemState with _$MediaItemState {
  const factory MediaItemState({
    required String mediaType,
    required String id,
    required String languageName,
  }) = _MediaItemState;
}
