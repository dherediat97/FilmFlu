import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/notifiers/models/home_state.dart';
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
        ? await ref
            .read(mediaRepositoryProvider)
            .getMediaDataDay(mediaTypeSelected)
        : null;

    return HomeState(
      uiState: UiState.success(),
      mediaTypeSelected: mediaTypeSelected,
      mediaItem: mediaItem,
    );
  }
}
