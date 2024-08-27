import 'package:film_flu/presentation/features/media_details/media_detail_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../pump_app.dart';

void main() {
  testWidgets('Testing Media Detail Screen', (WidgetTester tester) async {
    await pumpApp(
      tester: tester,
      child: const MediaItemScreenDetails(mediaTypeId: '1111'),
    );
  });
}
