import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class SplashController extends StatelessWidget {
  const SplashController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      route: AppRoutePaths.homeRoute,
    );
  }
}
