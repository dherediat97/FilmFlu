import 'package:bloc_test/bloc_test.dart';
import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/presentation/features/person_details/bloc/person_details_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:test/scaffolding.dart';

import 'person_detail_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PersonDetailsBloc>(),
])
void main() {
  late MockPersonDetailsBloc mockBlock;

  setUp(
    () {
      mockBlock = MockPersonDetailsBloc();
    },
  );

  group(
    'Testing PersonDetailScreen Bloc',
    () {
      blocTest(
        'Given PersonDetailBloc when load the bloc then return the empty expected result',
        build: () => mockBlock,
        expect: () => [],
      );

      blocTest(
        'Given PersonDetailBloc when load the bloc then return the expected result',
        build: () => mockBlock,
        act: (bloc) => bloc.add(const PersonDetailEvent.getPersonData(111)),
        expect: () => [
          PersonDetailsState.initial().copyWith(
            creditsAsActor: [],
            creditsAsProduction: [],
            person: null,
            uiState: const UiState.loading(),
          ),
          PersonDetailsState.initial().copyWith(
            creditsAsActor: [],
            creditsAsProduction: [],
            person: null,
            uiState: const UiState.success(),
          ),
        ],
      );
    },
  );
}
