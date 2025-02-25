import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([])
Future<void> pumpApp({
  required WidgetTester tester,
  required Widget child,
  required var providers,
}) async {
  final widget = ProviderScope(
    child: HomeScreen(),
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
