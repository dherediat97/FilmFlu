import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/presentation/features/person_details/widgets/person_details.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../instruments/pump_app.dart';

void main() {
  testWidgets('Testing Person Detail Screen', (WidgetTester tester) async {
    await pumpApp(
      tester,
      const PersonDetails(
        person: PersonEntity(name: 'name', gender: 0, alias: [], id: 0),
      ),
    );
  });
}
