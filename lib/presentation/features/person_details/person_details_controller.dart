import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/app/types/ui_state.dart';
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
    return BlocListener<PersonDetailsBloc, PersonDetailsState>(
      listenWhen: (previous, current) {
        return current.uiState.isSuccess();
      },
      listener: (context, state) {
        SplashScreen(
          route: '${AppRoutePaths.personDetailsRoute}/$personId',
        );
      },
      child: PersonDetailsPage(personId: personId),
    );
  }
}
