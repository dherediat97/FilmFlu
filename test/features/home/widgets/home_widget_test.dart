import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../pump_app.dart';

void main() {
  testWidgets('Testing Home Screen', (WidgetTester tester) async {
    await pumpApp(
      tester,
      const HomeScreen(),
    );
  });
}
