import 'package:bloc_test/bloc_test.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:test/scaffolding.dart';

void main() {
  group(
    'Testing Media Detail Screen Bloc',
    () {
      blocTest(
        'emits [] when nothing is added',
        build: () => MediaDetailBloc(repositoryContract: null),
        expect: () => [],
      );

      blocTest(
        'emits [1] when CounterIncrementPressed is added',
        build: () => MediaDetailBloc(repositoryContract: null),
        act: (bloc) =>
            bloc.add(const MediaDetailEvent.getMediaDetails('movie', '11111')),
        expect: () => [1],
      );
    },
  );
}
