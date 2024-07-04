part of 'person_detail_bloc.dart';

@freezed
class PersonDetailState with _$PersonDetailState {
  const factory PersonDetailState({
    required PersonEntity? person,
    required UiState uiState,
  }) = _PersonDetailState;

  factory PersonDetailState.initial() {
    return const PersonDetailState(
      person: null,
      uiState: UiState.initial(),
    );
  }
}
