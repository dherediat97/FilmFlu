import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required UiState uiState,
    required MediaType? mediaTypeSelected,
  }) = _HomeState;

  factory HomeState.initial() {
    return HomeState(
      uiState: UiState.initial(),
      mediaTypeSelected: null,
    );
  }
}
