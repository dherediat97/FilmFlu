import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        context
            .read<HomeBloc>()
            .add(HomeEvent.switchCategory(state.mediaTypeSelected));

        String route;
        switch (state.mediaTypeSelected) {
          case MediaType.movie:
            route = AppRoutePaths.moviesRoute;
            break;
          case MediaType.tv:
            route = AppRoutePaths.seriesRoute;
            break;
          case MediaType.search:
            route = AppRoutePaths.searchRoute;
            break;
          default:
            route = AppRoutePaths.moviesRoute;
            break;
        }
        return SplashScreen(route: route);
      },
    );
  }
}
