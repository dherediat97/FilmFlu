import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/domain/repository/person_repository.dart';
import 'package:film_flu/presentation/notifiers/models/person_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
final getPersonDetailsProvider =
    FutureProvider.family<PersonEntity, PersonState>((ref, personState) async {
  final personDetailsResponse = await ref
      .read(personRepositoryProvider)
      .fetchPersonData(personState.personId, personState.languageName);

  return personDetailsResponse;
});
