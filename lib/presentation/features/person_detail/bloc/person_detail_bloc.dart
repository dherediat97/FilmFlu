import 'package:FilmFlu/app/types/ui_state.dart';
import 'package:FilmFlu/domain/models/person_entity.dart';
import 'package:FilmFlu/domain/repository_contracts/person_repository_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_detail_event.dart';
part 'person_detail_state.dart';
part 'person_detail_bloc.freezed.dart';

class PersonDetailBloc extends Bloc<PersonDetailEvent, PersonDetailState> {
  final PersonRepositoryContract _repository;

  PersonDetailBloc({
    required PersonRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(PersonDetailState.initial()) {
    on<PersonDetailEvent>((event, emit) async {
      await event.when(
        getPersonData: (String personId) => _getPersonData(
          event,
          emit,
          personId,
        ),
      );
    });
  }

  _getPersonData(
    PersonDetailEvent event,
    Emitter<PersonDetailState> emit,
    String personId,
  ) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final personData = await _repository.fetchPersonData(personId);
    personData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error(), person: null),
        );
      },
      success: (value) =>
          emit(state.copyWith(uiState: const UiState.success(), person: value)),
    );
  }
}
