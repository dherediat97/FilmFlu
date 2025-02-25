import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@riverpod
class Home extends _$Home {
  @override
  Future<HomeState> build(MediaFilter mediaFilter) {
    return getHomeData(mediaFilter);
  }

  Future<HomeState> getHomeData(MediaFilter mediaFilter) async {
    if (state.value?.mediaFilter == mediaFilter) {
      return state.value!;
    }

    final mediaItem = mediaFilter.mediaTypeSelected != MediaType.search
        ? ref.read(mediaRepositoryProvider).getMediaDataDay(mediaFilter)
        : null;

    return HomeState(
      uiState: UiState.success(),
      mediaFilter: mediaFilter,
      mediaItem: mediaItem,
    );
  }
}

class HomeState {
  final UiState uiState;
  final MediaFilter? mediaFilter;
  final Future<MediaItemEntity>? mediaItem;

  HomeState({
    required this.uiState,
    required this.mediaFilter,
    required this.mediaItem,
  });

  factory HomeState.initial() {
    return HomeState(
      uiState: UiState.initial(),
      mediaFilter: null,
      mediaItem: null,
    );
  }

  HomeState copyWith({
    UiState? uiState,
    MediaFilter? mediaFilter,
    Future<MediaItemEntity>? mediaItem,
  }) {
    return HomeState(
      uiState: uiState ?? this.uiState,
      mediaFilter: mediaFilter ?? this.mediaFilter,
      mediaItem: mediaItem ?? this.mediaItem,
    );
  }
}
