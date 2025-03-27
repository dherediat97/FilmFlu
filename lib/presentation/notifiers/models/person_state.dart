import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_state.freezed.dart';

@freezed
class PersonState with _$PersonState {
  const factory PersonState({
    required int personId,
    required String languageName,
  }) = _PersonState;
}
