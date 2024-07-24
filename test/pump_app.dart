import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpApp(WidgetTester tester, Widget child) {
  return tester.pumpWidget(MultiBlocProvider(
      providers: const [],
      child: MaterialApp(
        home: child,
      )));
}
