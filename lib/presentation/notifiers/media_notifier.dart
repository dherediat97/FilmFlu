import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final fetchMediaDayProvider =
    FutureProvider.family<MediaDayItemState, MediaType>(
  (ref, mediaTypeSelected) async {
    final mediaDataItemResponse =
        await ref.watch(mediaRepositoryProvider).getMediaDataDay(
              MediaType.values
                  .firstWhere((mediaType) => mediaType == mediaTypeSelected),
            );
    return MediaDayItemState(
      mediaItem: mediaDataItemResponse,
      title: mediaTypeSelected == MediaType.movie
          ? mediaDataItemResponse.title
          : mediaDataItemResponse.name,
      productionCompanyImage:
          mediaDataItemResponse.productionCompanies!.isNotEmpty
              ? mediaDataItemResponse.productionCompanies!.first.logoPath
              : '',
      uiState: UiState.success(),
    );
  },
);

final fetchMediaItemProvider =
    FutureProvider.family<MediaItemDetailState, MediaItemState>((
  ref,
  mediaItemState,
) async {
  final mediaItemResponse =
      await ref.watch(mediaRepositoryProvider).getMediaItem(
            MediaType.values.firstWhere(
                (mediaType) => mediaType.name == mediaItemState.mediaType),
            mediaItemState.id,
          );

  return MediaItemDetailState(
    trailerId: _getFirstTrailerId(mediaItemResponse),
    isTrailerOpened: false,
    title: mediaItemState.mediaType == MediaType.movie.name
        ? mediaItemResponse.title
        : mediaItemResponse.name,
    uiState: UiState.success(),
    mediaItem: mediaItemResponse,
    productionCompanyImage: mediaItemResponse.productionCompanies!.isNotEmpty
        ? mediaItemResponse.productionCompanies!.first.logoPath
        : '',
  );
});

final fetchCreditsProvider =
    Provider.family<Future<CreditsMediaEntity?>, CreditsMediaState>((
  ref,
  creditsMediaState,
) {
  return ref.watch(mediaRepositoryProvider).getCredits(
        MediaType.values.firstWhere(
            (mediaType) => mediaType.name == creditsMediaState.mediaType),
        creditsMediaState.id,
      );
});

final fetchReviewsProvider =
    Provider.family<Future<List<ReviewEntity>?>, MediaItemState>((
  ref,
  mediaItemState,
) {
  return ref.watch(mediaRepositoryProvider).getReviews(
        MediaType.values.firstWhere(
            (mediaType) => mediaType.name == mediaItemState.mediaType),
        mediaItemState.id,
      );
});

final fetchMediaProvider =
    Provider.family<Future<MediaResponseEntity>, MediaItemState>((
  ref,
  mediaItemState,
) {
  return ref.watch(mediaRepositoryProvider).getMedia(
        MediaType.values.firstWhere(
            (mediaType) => mediaType.name == mediaItemState.mediaType),
        mediaItemState.id,
      );
});

// final fetchPaginateMediaProvider =
//     Provider.family<MediaListResponse, MediaListPaginateState>((
//   ref,
//   mediaListState,
// ) {
//   final paginateResponseMediaData =
//       ref.watch(mediaRepositoryProvider).paginateMediaData(
//             genreId: mediaListState.genreId,
//             mediaTypeSelected: MediaType.values.firstWhere(
//                 (mediaType) => mediaType.name == mediaListState.mediaType),
//             page: mediaListState.page,
//           );

//   return MediaListPaginateState(
//     movieData: paginateResponseMediaData.where((element) {
//       return element.mediaType == MediaType.movie;
//     }).toList(),
//     serieData: serieData,
//     page: mediaListState.page,
//   );
// });

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

class MediaItemState {
  final String mediaType;
  final String id;

  const MediaItemState({
    required this.mediaType,
    required this.id,
  });
}

class CreditsMediaState {
  final String mediaType;
  final String id;
  final bool isCast;

  const CreditsMediaState({
    required this.mediaType,
    required this.id,
    required this.isCast,
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

class MediaListPaginateState {
  final MediaType mediaType;
  final int genreId;
  final String languageId;
  final int page;

  const MediaListPaginateState({
    required this.mediaType,
    required this.genreId,
    required this.languageId,
    required this.page,
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

class MediaItemDetailState {
  final MediaItemEntity? mediaItem;
  final String? title;
  final String trailerId;
  final String? productionCompanyImage;
  final List<ReviewEntity>? reviews;
  final List<ActorEntity>? cast;
  final List<FilmWorkerEntity>? crew;
  final MediaResponseEntity? mediaList;
  final bool isTrailerOpened;
  final UiState uiState;

  MediaItemDetailState copyWith({
    MediaItemEntity? mediaItem,
    String? title,
    String? trailerId,
    String? productionCompanyImage,
    List<ReviewEntity>? reviews,
    List<ActorEntity>? cast,
    List<FilmWorkerEntity>? crew,
    MediaResponseEntity? mediaList,
    bool? isTrailerOpened,
    UiState? uiState,
  }) {
    return MediaItemDetailState(
      mediaItem: mediaItem ?? this.mediaItem,
      title: title ?? this.title,
      trailerId: trailerId ?? this.trailerId,
      productionCompanyImage: productionCompanyImage,
      reviews: reviews ?? this.reviews,
      cast: cast ?? this.cast,
      crew: crew ?? this.crew,
      mediaList: mediaList ?? this.mediaList,
      isTrailerOpened: isTrailerOpened ?? this.isTrailerOpened,
      uiState: uiState ?? this.uiState,
    );
  }

  const MediaItemDetailState({
    this.mediaItem,
    this.title,
    required this.trailerId,
    this.productionCompanyImage,
    this.reviews,
    this.cast,
    this.crew,
    this.mediaList,
    required this.isTrailerOpened,
    required this.uiState,
  });
}

class MediaDayItemState {
  final MediaItemEntity? mediaItem;
  final String? title;
  final String? productionCompanyImage;
  final UiState uiState;

  MediaDayItemState copyWith({
    MediaItemEntity? mediaItem,
    String? title,
    String? trailerId,
    String? productionCompanyImage,
    List<ReviewEntity>? reviews,
    List<ActorEntity>? cast,
    List<FilmWorkerEntity>? crew,
    MediaResponseEntity? mediaList,
    bool? isTrailerOpened,
    UiState? uiState,
  }) {
    return MediaDayItemState(
      mediaItem: mediaItem ?? this.mediaItem,
      title: title ?? this.title,
      productionCompanyImage: productionCompanyImage,
      uiState: uiState ?? this.uiState,
    );
  }

  const MediaDayItemState({
    this.mediaItem,
    this.title,
    this.productionCompanyImage,
    required this.uiState,
  });
}
