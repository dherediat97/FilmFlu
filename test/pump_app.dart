import 'package:film_flu/app/constants/app_fonts.dart';
import 'package:film_flu/app/constants/app_theme.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:film_flu/presentation/top_blocs/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pump_app.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AppBloc>(),
])
Future<void> pumpApp({
  required WidgetTester tester,
  required Widget child,
  required var providers,
}) async {
  final appBloc = MockAppBloc();
  when(appBloc.state).thenReturn(
    AppState.initial().copyWith(
      locale: const Locale('es'),
      isDarkMode: true,
      theme: AppTheme(createTextTheme(isLightMode: false)),
    ),
  );

  final widget = MultiBlocProvider(
    providers: [
      ...providers,
      BlocProvider<AppBloc>(
        create: (_) => appBloc,
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
}
