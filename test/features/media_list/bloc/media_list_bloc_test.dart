import 'package:bloc_test/bloc_test.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:test/scaffolding.dart';

import 'media_list_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MediaListBloc>(),
])
void main() {
  late MockMediaListBloc mockBlock;

  setUp(
    () {
      mockBlock = MockMediaListBloc();
    },
  );

  group(
    'Testing Home Screen Bloc',
    () {
      blocTest(
        'Given Home Screen Bloc when load the bloc then return the empty expected result',
        build: () => mockBlock,
        expect: () => [],
      );

      blocTest(
        'Given HomeScreenBloc when load the bloc then return the expected result',
        build: () => mockBlock,
        act: (bloc) =>
            bloc.add(const MediaListEvent.getMediaDataByGenre('action', 0)),
        expect: () => [
          MediaListState.initial().copyWith(
            mediaList: List.empty(),
          ),
        ],
      );
    },
  );
}
