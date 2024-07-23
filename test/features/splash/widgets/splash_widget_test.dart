import 'package:film_flu/presentation/features/splash/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const SplashScreen(
        route: '/',
      ),
    );
  });
}
