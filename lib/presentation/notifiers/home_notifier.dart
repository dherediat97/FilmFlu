import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final switchCategoryProvider = FutureProvider.family<HomeState, MediaType>((
  ref,
  mediaTypeSelected,
) {
  // final mediaItem =
  //     ref.watch(mediaRepositoryProvider).getMediaDataDay(mediaTypeSelected);

  return HomeState(
    uiState: UiState.success(),
    mediaTypeSelected: mediaTypeSelected,
    mediaItem: null,
  );
});

class HomeState {
  final UiState uiState;
  final MediaType mediaTypeSelected;
  final Future<MediaItemEntity>? mediaItem;

  HomeState({
    required this.uiState,
    required this.mediaTypeSelected,
    required this.mediaItem,
  });

  factory HomeState.initial() {
    return HomeState(
      uiState: UiState.initial(),
      mediaTypeSelected: MediaType.movie,
      mediaItem: null,
    );
  }

  HomeState copyWith({
    UiState? uiState,
    MediaType? mediaTypeSelected,
    Future<MediaItemEntity>? mediaItem,
  }) {
    return HomeState(
      uiState: uiState ?? this.uiState,
      mediaTypeSelected: mediaTypeSelected ?? this.mediaTypeSelected,
      mediaItem: mediaItem ?? this.mediaItem,
    );
  }
}
