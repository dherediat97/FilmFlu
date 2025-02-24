import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/notifiers/media_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_detail_notifier.g.dart';

@riverpod
Future<MediaItemDetailState> fetchMediaItem(
  Ref ref,
  MediaItemState mediaItemState,
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
    mediaItem: mediaItemResponse,
    productionCompanyImage: mediaItemResponse.productionCompanies!.isNotEmpty
        ? mediaItemResponse.productionCompanies!.first.logoPath
        : '',
  );
}

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
  });
}
