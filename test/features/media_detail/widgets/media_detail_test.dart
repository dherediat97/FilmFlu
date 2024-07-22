import 'package:film_flu/presentation/features/media_details/media_detail_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing Media Detail Screen', (WidgetTester tester) async {
    tester.pumpWidget(
      const MediaItemScreenDetails(mediaTypeId: '1111'),
    );
  });
}
