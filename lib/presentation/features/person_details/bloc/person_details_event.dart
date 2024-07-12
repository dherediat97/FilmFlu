part of 'person_details_bloc.dart';

@freezed
class PersonDetailEvent with _$PersonDetailEvent {
  const factory PersonDetailEvent.getPersonData(int personId) = _GetPersonData;
}
