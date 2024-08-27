import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/features/search/search_screen.dart';
import 'package:film_flu/presentation/top_blocs/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_widget_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AppBloc>(),
  MockSpec<HomeBloc>(),
  MockSpec<MediaListBloc>(),
])
void main() {
  testWidgets('HomeBloc adds switchCategory event with MediaType.movie',
      (WidgetTester tester) async {
    final appBloc = MockAppBloc();
    final homeBloc = MockHomeBloc();
    final mediaListBloc = MockMediaListBloc();
    when(appBloc.state).thenReturn(AppState.initial());
    when(homeBloc.state).thenReturn(
      HomeState.initial().copyWith(
        mediaTypeSelected: MediaType.movie,
      ),
    );
    when(mediaListBloc.state).thenReturn(MediaListState.initial());

    final widget = MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => appBloc,
        ),
        BlocProvider<HomeBloc>(
          create: (_) => homeBloc,
        ),
        BlocProvider<MediaListBloc>(
          create: (_) => mediaListBloc,
        ),
      ],
      child: const HomeScreen(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: widget,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    homeBloc.add(const HomeEvent.switchCategory(MediaType.movie));

    expect(find.byType(MoviesListWidget), findsOneWidget);
  });

  testWidgets('HomeBloc adds switchCategory event with MediaType.tv',
      (WidgetTester tester) async {
    final appBloc = MockAppBloc();
    final homeBloc = MockHomeBloc();
    final mediaListBloc = MockMediaListBloc();
    when(appBloc.state).thenReturn(AppState.initial());
    when(homeBloc.state).thenReturn(
      HomeState.initial().copyWith(
        mediaTypeSelected: MediaType.tv,
      ),
    );
    when(mediaListBloc.state).thenReturn(MediaListState.initial());

    final widget = MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => appBloc,
        ),
        BlocProvider<HomeBloc>(
          create: (_) => homeBloc,
        ),
        BlocProvider<MediaListBloc>(
          create: (_) => mediaListBloc,
        ),
      ],
      child: const HomeScreen(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: widget,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    homeBloc.add(const HomeEvent.switchCategory(MediaType.tv));

    expect(find.byType(SeriesListWidget), findsOneWidget);
  });

  testWidgets('HomeBloc adds switchCategory event with MediaType.tv',
      (WidgetTester tester) async {
    final appBloc = MockAppBloc();
    final homeBloc = MockHomeBloc();
    final mediaListBloc = MockMediaListBloc();
    when(appBloc.state).thenReturn(AppState.initial());
    when(homeBloc.state).thenReturn(
      HomeState.initial().copyWith(
        mediaTypeSelected: MediaType.search,
      ),
    );
    when(mediaListBloc.state).thenReturn(MediaListState.initial());

    final widget = MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => appBloc,
        ),
        BlocProvider<HomeBloc>(
          create: (_) => homeBloc,
        ),
        BlocProvider<MediaListBloc>(
          create: (_) => mediaListBloc,
        ),
      ],
      child: const HomeScreen(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: widget,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    homeBloc.add(const HomeEvent.switchCategory(MediaType.search));

    expect(find.byType(SearchScreen), findsOneWidget);
  });

  testWidgets('HomeBloc fails to add switchCategory event',
      (WidgetTester tester) async {
    final appBloc = MockAppBloc();
    final homeBloc = MockHomeBloc();
    final mediaListBloc = MockMediaListBloc();
    when(appBloc.state).thenReturn(AppState.initial());
    when(homeBloc.state).thenReturn(HomeState.initial());
    when(mediaListBloc.state).thenReturn(MediaListState.initial());
    when(appBloc.add(any)).thenThrow(Exception('Failed to add event'));
    when(homeBloc.add(any)).thenThrow(Exception('Failed to add event'));
    when(mediaListBloc.add(any)).thenThrow(Exception('Failed to add event'));

    final widget = MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => appBloc,
        ),
        BlocProvider<HomeBloc>(
          create: (_) => homeBloc,
        ),
        BlocProvider<MediaListBloc>(
          create: (_) => mediaListBloc,
        ),
      ],
      child: const HomeScreen(),
    );

    await tester.pumpWidget(MaterialApp(
      home: widget,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    ));

    expect(() => homeBloc.add(const HomeEvent.switchCategory(MediaType.movie)),
        throwsException);
  });
}
