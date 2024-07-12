import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/splash_screen/bloc/splash_bloc.dart';
import 'package:film_flu/presentation/features/splash_screen/bloc/splash_state.dart';
import 'package:film_flu/presentation/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashController extends StatelessWidget {
  const SplashController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.isSplashed()) {
          context.push(AppRoutePaths.homeRoute);
        }
      },
      builder: (context, state) {
        return const SplashPage();
      },
    );
  }
}
