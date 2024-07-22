part of 'person_details_bloc.dart';

@freezed
class PersonDetailsState with _$PersonDetailsState {
  const factory PersonDetailsState({
    required PersonEntity? person,
    required List<CreditProductionEntity>? creditsAsProduction,
    required List<CreditActorEntity>? creditsAsActor,
    required UiState uiState,
  }) = _PersonDetailsState;

  factory PersonDetailsState.initial() {
    return const PersonDetailsState(
      person: null,
      creditsAsActor: [],
      creditsAsProduction: [],
      uiState: UiState.initial(),
    );
  }
}
