import 'package:FilmFlu/presentation/features/home/home_screen.dart';
import 'package:FilmFlu/presentation/features/movie_list/bloc/media_list_bloc.dart';
import 'package:FilmFlu/presentation/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeController extends StatelessWidget {
  const HomeController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
      builder: (context, state) {
        return state.uiState.when(
          success: () => const HomeScreen(),
          loading: () => const SplashPage(),
          error: (error) => Text(error ?? ''),
          initial: () => const SplashPage(),
        );
      },
    );
  }
}
