import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../pump_app.dart';

void main() {
  testWidgets('Testing Media List Screen', (WidgetTester tester) async {
    await pumpApp(
      tester,
      const MediaList(),
    );
  });
}
