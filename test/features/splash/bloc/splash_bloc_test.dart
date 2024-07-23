import 'package:bloc_test/bloc_test.dart';
import 'package:film_flu/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:test/scaffolding.dart';

import 'splash_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SplashBloc>(),
])
void main() {
  late MockSplashBloc mockBlock;

  setUp(
    () {
      mockBlock = MockSplashBloc();
    },
  );

  group(
    'Testing SplashBlocScreen Bloc',
    () {
      blocTest(
        'Given SplashBloc when load the bloc then return the empty expected result',
        build: () => mockBlock,
        expect: () => [],
      );

      blocTest(
        'Given SplashBloc when load the bloc then return the expected result',
        build: () => mockBlock,
        act: (bloc) =>
            bloc.add(const SplashEvent.unSplashInNMilliseconds(5000)),
        expect: () => [
          const SplashState.splashed(),
        ],
      );
    },
  );
}
