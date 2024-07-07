import 'package:film_flu/app/di/top_bloc_providers.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeController extends StatelessWidget {
  const HomeController({super.key});

  @override
  Widget build(BuildContext context) {
    return TopBlocProviders(
      child: BlocBuilder<MediaListBloc, MediaListState>(
        builder: (context, state) {
          return state.uiState.when(
            success: () => const HomeScreen(),
            loading: () => SplashPage(routePath: AppRoutePaths.home),
            initial: () {
              context
                  .read<MediaListBloc>()
                  .add(const MediaListEvent.getMediaData());
              return Container();
            },
            error: (error) => const Text('An error happened'),
          );
        },
      ),
    );
  }
}
