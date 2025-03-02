import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/data/enums/media_type.dart';
import 'package:film_flu/presentation/notifiers/models/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@riverpod
class Home extends _$Home {
  @override
  HomeState build(MediaType mediaFilter) {
    return getHomeData(mediaFilter);
  }

  HomeState getHomeData(MediaType mediaTypeSelected) {
    return HomeState(
      uiState: UiState.success(),
      mediaTypeSelected: mediaTypeSelected,
    );
  }
}
