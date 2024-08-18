import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/credit_actor_entity.dart';
import 'package:film_flu/domain/models/credit_production_entity.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/domain/repository_contracts/person_repository_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_details_event.dart';
part 'person_details_state.dart';
part 'person_details_bloc.freezed.dart';

class PersonDetailsBloc extends Bloc<PersonDetailEvent, PersonDetailsState> {
  final PersonRepositoryContract _repository;

  PersonDetailsBloc({
    required PersonRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(PersonDetailsState.initial()) {
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
    Emitter<PersonDetailsState> emit,
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
      success: (value) {
        List<CreditActorEntity> creditsAsActor = List.empty();
        List<CreditProductionEntity> creditsAsProduction = List.empty();
        if (value.credits != null) {
          creditsAsActor = value.credits!.cast
              .where((element) => element.character != null)
              .where((element) => element.title != null)
              .toList();

          creditsAsProduction = value.credits!.crew
              .where((element) => element.job != null)
              .where((element) => element.title != null)
              .toList();
        }
        emit(state.copyWith(
          uiState: const UiState.success(),
          person: value,
          creditsAsActor: creditsAsActor,
          creditsAsProduction: creditsAsProduction,
        ));
      },
    );
  }
}
