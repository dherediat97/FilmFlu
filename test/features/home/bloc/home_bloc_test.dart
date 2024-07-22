import 'package:bloc_test/bloc_test.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:test/scaffolding.dart';

void main() {
  group(
    'Testing Home Screen Bloc',
    () {
      blocTest(
        'emits [] when nothing is added',
        build: () => MediaListBloc(repositoryContract: null),
        expect: () => [],
      );

      blocTest(
        'emits [1] when CounterIncrementPressed is added',
        build: () => MediaListBloc(repositoryContract: null),
        act: (bloc) => bloc.add(const MediaListEvent.getMediaData()),
        expect: () => [1],
      );
    },
  );
}
