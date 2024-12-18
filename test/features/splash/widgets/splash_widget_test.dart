import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../pump_app.dart';
import 'splash_widget_test.mocks.dart';

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

  testWidgets('Testing SplashScreen', (WidgetTester tester) async {
    when(homeBloc.state).thenReturn(
      HomeState.initial().copyWith(
        uiState: const UiState.success(),
        mediaTypeSelected: MediaType.movie,
      ),
    );

    await pumpApp(
      tester: tester,
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => homeBloc,
        ),
      ],
      child: const SplashScreen(
        route: '/',
      ),
    );
  });
}
