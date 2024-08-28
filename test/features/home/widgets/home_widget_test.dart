import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/features/search/search_screen.dart';
import 'package:film_flu/presentation/top_blocs/app/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../pump_app.dart';
import 'home_widget_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AppBloc>(),
  MockSpec<HomeBloc>(),
  MockSpec<MediaListBloc>(),
])
void main() {
  late MockHomeBloc homeBloc;
  late MockMediaListBloc mediaListBloc;

  setUpAll(
    () {
      homeBloc = MockHomeBloc();
      mediaListBloc = MockMediaListBloc();
    },
  );

  testWidgets('HomeBloc adds switchCategory event with MediaType.movie',
      (WidgetTester tester) async {
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
      child: const HomeScreen(),
    );

    homeBloc.add(const HomeEvent.switchCategory(MediaType.movie));

    expect(find.byType(MoviesListWidget), findsOneWidget);
  });

  testWidgets('HomeBloc adds switchCategory event with MediaType.tv',
      (WidgetTester tester) async {
    when(homeBloc.state).thenReturn(
      HomeState.initial().copyWith(
        mediaTypeSelected: MediaType.tv,
      ),
    );
    when(mediaListBloc.state).thenReturn(MediaListState.initial());

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
      child: const HomeScreen(),
    );

    homeBloc.add(const HomeEvent.switchCategory(MediaType.tv));

    expect(find.byType(SeriesListWidget), findsOneWidget);
  });

  testWidgets('HomeBloc adds switchCategory event with MediaType.tv',
      (WidgetTester tester) async {
    when(homeBloc.state).thenReturn(
      HomeState.initial().copyWith(
        mediaTypeSelected: MediaType.movie,
        uiState: const UiState.success(),
      ),
    );
    when(mediaListBloc.state).thenReturn(MediaListState.initial().copyWith(
      uiState: const UiState.success(),
    ));

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
      child: const HomeScreen(),
    );

    homeBloc.add(const HomeEvent.switchCategory(MediaType.search));

    expect(find.byType(SearchScreen), findsOneWidget);
  });

  testWidgets('HomeBloc fails to add switchCategory event',
      (WidgetTester tester) async {
    when(homeBloc.state).thenReturn(HomeState.initial());
    when(mediaListBloc.state).thenReturn(MediaListState.initial());
    when(homeBloc.add(any)).thenThrow(Exception('Failed to add event'));
    when(mediaListBloc.add(any)).thenThrow(Exception('Failed to add event'));

    await pumpApp(
      tester: tester,
      child: const HomeScreen(),
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => homeBloc,
        ),
        BlocProvider<MediaListBloc>(
          create: (_) => mediaListBloc,
        ),
      ],
    );

    expect(() => homeBloc.add(const HomeEvent.switchCategory(MediaType.movie)),
        throwsException);
  });
}
