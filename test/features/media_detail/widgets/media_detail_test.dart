import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_view_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../instruments/media_detail_instruments.dart';
import '../../../pump_app.dart';
import 'media_detail_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HomeBloc>(),
])
void main() {
  late MockHomeBloc homeBloc;

  setUpAll(
    () {
      homeBloc = MockHomeBloc();
    },
  );

  testWidgets('Media Details Test', (WidgetTester tester) async {
    when(homeBloc.state).thenReturn(
      HomeState.initial().copyWith(
        uiState: const UiState.success(),
        mediaTypeSelected: MediaType.movie,
        mediaItem: MediaDetailInstruments.mediaDetailMocked,
      ),
    );

    await pumpApp(
      tester: tester,
      child: const MediaDetailController(
        mediaType: MediaType.movie,
        mediaId: MediaDetailInstruments.movieIdMocked,
      ),
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => homeBloc,
        ),
      ],
    );
  });
}
