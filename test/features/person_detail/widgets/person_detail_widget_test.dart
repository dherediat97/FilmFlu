import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/person_entity.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/person_details/bloc/person_details_bloc.dart';
import 'package:film_flu/presentation/features/person_details/widgets/person_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../pump_app.dart';
import 'person_detail_widget_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HomeBloc>(),
  MockSpec<PersonDetailsBloc>(),
])
void main() {
  late MockPersonDetailsBloc personDetailBloc;
  late MockHomeBloc homeBloc;

  setUpAll(
    () {
      personDetailBloc = MockPersonDetailsBloc();
      homeBloc = MockHomeBloc();
    },
  );

  testWidgets('Testing Person Detail Screen', (WidgetTester tester) async {
    when(homeBloc.state).thenReturn(
      HomeState.initial().copyWith(
        uiState: const UiState.success(),
        mediaTypeSelected: MediaType.movie,
      ),
    );

    when(personDetailBloc.state).thenReturn(
      PersonDetailsState.initial().copyWith(
        uiState: const UiState.success(),
      ),
    );

    await pumpApp(
      tester: tester,
      child: const PersonDetails(
        person: PersonEntity(name: 'name', gender: 0, alias: [], id: 0),
      ),
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => homeBloc,
        ),
        BlocProvider<PersonDetailsBloc>(
          create: (_) => personDetailBloc,
        ),
      ],
    );
  });
}
