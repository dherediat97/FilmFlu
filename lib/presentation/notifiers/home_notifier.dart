import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@riverpod
class Home extends _$Home {
  @override
  Future<HomeState> build(MediaType mediaFilter) {
    return getHomeData(mediaFilter);
  }

  Future<HomeState> getHomeData(MediaType mediaTypeSelected) async {
    if (state.value?.mediaTypeSelected == mediaTypeSelected) {
      return state.value!;
    }

    final mediaItem = mediaTypeSelected != MediaType.search
        ? ref.read(mediaRepositoryProvider).getMediaDataDay(mediaTypeSelected)
        : null;

    return HomeState(
      uiState: UiState.success(),
      mediaTypeSelected: mediaTypeSelected,
      mediaItem: mediaItem,
    );
  }
}

class HomeState {
  final UiState uiState;
  final MediaType? mediaTypeSelected;
  final Future<MediaItemEntity>? mediaItem;

  HomeState({
    required this.uiState,
    required this.mediaTypeSelected,
    required this.mediaItem,
  });

  factory HomeState.initial() {
    return HomeState(
      uiState: UiState.initial(),
      mediaTypeSelected: null,
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
