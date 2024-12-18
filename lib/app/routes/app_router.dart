import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_view_controller.dart';
import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/search/search_screen.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/features/person_details/person_details_controller.dart';
import 'package:film_flu/presentation/features/settings/settings_screen.dart';
import 'package:film_flu/presentation/features/splash/splash_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horusvision/presentation/features/horusvision.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final routerKey = GlobalKey<NavigatorState>();

  return GoRouter(
    initialLocation: '/',
    navigatorKey: routerKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            kIsWeb ? const HomeScreen() : const SplashController(),
        routes: [
          GoRoute(
            path: 'main',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                  path: 'movies',
                  builder: (context, state) => const MoviesListWidget(),
                  routes: [
                    GoRoute(
                      path: ':mediaId',
                      builder: (context, state) => MediaDetailController(
                        mediaType: MediaType.movie,
                        mediaId: state.pathParameters['mediaId'].toString(),
                      ),
                    ),
                  ]),
              GoRoute(
                  path: 'series',
                  builder: (context, state) => const SeriesListWidget(),
                  routes: [
                    GoRoute(
                      path: ':mediaTypeId',
                      builder: (context, state) => MediaDetailController(
                        mediaType: MediaType.tv,
                        mediaId: state.pathParameters['mediaTypeId'].toString(),
                      ),
                    ),
                  ]),
              GoRoute(
                path: 'search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'personDetails/:personId',
            builder: (context, state) => PersonDetailsController(
              personId: state.pathParameters['personId'].toString(),
            ),
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: 'horusVision',
            builder: (context, state) => const HorusVision(),
          ),
        ],
      ),
    ],
  );
}
