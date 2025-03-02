import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_item_states.freezed.dart';

@freezed
class MediaItemDetailState with _$MediaItemDetailState {
  const factory MediaItemDetailState({
    @Default(null) MediaItemEntity? mediaItem,
    String? title,
    @Default([]) List<String> trailerIds,
    @Default([]) List<String?> productionCompanyImages,
    @Default([]) List<ReviewEntity> reviews,
    @Default([]) List<ActorEntity> cast,
    @Default([]) List<FilmWorkerEntity> crew,
    MediaResponseEntity? mediaList,
    @Default(false) bool isTrailerOpened,
  }) = _MediaItemDetailState;
}

@freezed
class CreditsMediaState with _$CreditsMediaState {
  const factory CreditsMediaState({
    required String mediaType,
    required String id,
    required String languageName,
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
