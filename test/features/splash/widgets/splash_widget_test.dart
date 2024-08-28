import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../pump_app.dart';
import 'splash_widget_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HomeBloc>(),
  MockSpec<MediaListBloc>(),
])
void main() {
  late MockMediaListBloc mediaListBloc;
  late MockHomeBloc homeBloc;

  setUpAll(
    () {
      mediaListBloc = MockMediaListBloc();
      homeBloc = MockHomeBloc();
    },
  );

  testWidgets('Testing SplashScreen', (WidgetTester tester) async {
    when(homeBloc.state).thenReturn(
      HomeState.initial().copyWith(
        uiState: const UiState.success(),
        mediaTypeSelected: MediaType.movie,
      ),
    );

    when(mediaListBloc.state).thenReturn(
      MediaListState.initial().copyWith(
        uiState: const UiState.success(),
      ),
    );

    await pumpApp(
      tester: tester,
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => homeBloc,
        ),
        BlocProvider<MediaListBloc>(
          create: (_) => mediaListBloc,
        ),
      ],
      child: const SplashScreen(
        route: '/',
      ),
    );
  });
}
