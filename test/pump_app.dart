import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'instruments/mock_go_router.dart';

Future<void> pumpApp(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp.router(
      routerConfig: MockGoRouter(),
    ),
  );
}
