import 'package:bloc_test/bloc_test.dart';
import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';

import 'media_detail_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MediaDetailBloc>()])
void main() {
  late MockMediaDetailBloc mockBlock;

  setUp(
    () {
      mockBlock = MockMediaDetailBloc();
    },
  );

  group(
    'Testing Media Detail Screen Bloc',
    () {
      blocTest(
        'Given MediaDetailBloc when load the bloc then return the empty expected result',
        build: () => mockBlock,
        expect: () => [],
      );

      blocTest(
        'Given MediaDetailBloc when load the bloc then return the expected result',
        build: () => mockBlock,
        act: (bloc) =>
            bloc.add(const MediaDetailEvent.getMediaDetails('movie', '11111')),
        expect: () => [
          MediaDetailState.initial().copyWith(
            credits: null,
            isCastSelected: true,
            isTrailerOpened: false,
            mediaItem: null,
            movieName: '',
            trailerId: '',
            uiState: const UiState.loading(),
          ),
          MediaDetailState.initial().copyWith(
            credits: null,
            isCastSelected: true,
            isTrailerOpened: false,
            mediaItem: null,
            movieName: '',
            trailerId: '',
            uiState: const UiState.success(),
          ),
        ],
      );
    },
  );
}
