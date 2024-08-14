import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpApp(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      home: child,
    ),
  );
}
