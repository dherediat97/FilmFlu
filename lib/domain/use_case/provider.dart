import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/domain/repository/person_repository.dart';
import 'package:film_flu/domain/use_case/media_use_case.dart';
import 'package:film_flu/domain/use_case/person_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final mediaProvider = Provider<MediaUseCase>((ref) {
  return MediaUseCaseImpl(ref.watch(mediaRepositoryProvider));
});

final personProvider = Provider<PersonUseCase>((ref) {
  return PersonUseCaseImpl(ref.watch(personRepositoryProvider));
});
