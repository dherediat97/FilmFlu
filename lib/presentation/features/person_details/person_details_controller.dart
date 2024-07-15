import 'package:film_flu/app/di/top_bloc_providers.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/person_details/bloc/person_details_bloc.dart';
import 'package:film_flu/presentation/features/person_details/person_details_screen.dart';
import 'package:film_flu/presentation/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonDetailsController extends StatelessWidget {
  const PersonDetailsController({
    super.key,
    required this.personId,
  });

  final String personId;

  @override
  Widget build(BuildContext context) {
    return TopBlocProviders(
      child: BlocBuilder<PersonDetailsBloc, PersonDetailsState>(
        builder: (context, state) {
          return state.uiState.when(
            initial: () => Container(),
            success: () => PersonDetailsPage(personId: personId),
            error: (error) => Container(),
            loading: () => SplashScreen(
              route: '${AppRoutePaths.personDetailsRoute}/$personId',
            ),
          );
        },
      ),
    );
  }
}
