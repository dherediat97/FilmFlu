part of 'person_detail_bloc.dart';

@freezed
class PersonDetailEvent with _$PersonDetailEvent {
  const factory PersonDetailEvent.getPersonData(String personId) =
      _GetPersonData;
}
