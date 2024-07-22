import 'package:film_flu/app/di/top_bloc_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpApp(WidgetTester tester, Widget child) {
  return tester.pumpWidget(TopBlocProviders(child: child));
}
