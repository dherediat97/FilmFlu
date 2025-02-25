import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/domain/use_case/media_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final mediaProvider = Provider<MediaUseCase>((ref) {
  return MediaUseCaseImpl(ref.watch(mediaRepositoryProvider));
});
