import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/data/enums/media_type.dart';
import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_screen.dart';
import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/person_details/person_details_screen.dart';
import 'package:film_flu/presentation/features/search/search_screen.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/features/settings/settings_screen.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:horusvision/presentation/features/horusvision.dart';
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
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'main',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                  path: 'movie',
                  builder: (context, state) => const MoviesListWidget(),
                  routes: [
                    GoRoute(
                      path: ':mediaId',
                      builder: (context, state) => MediaItemScreenDetails(
                        languageCode: context.localizations.localeName,
                        mediaType: MediaType.movie.name,
                        mediaId: state.pathParameters['mediaId'].toString(),
                      ),
                    ),
                  ]),
              GoRoute(
                  path: 'tv',
                  builder: (context, state) => const SeriesListWidget(),
                  routes: [
                    GoRoute(
                      path: ':mediaTypeId',
                      builder: (context, state) => MediaItemScreenDetails(
                        languageCode: context.localizations.localeName,
                        mediaType: MediaType.tv.name,
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
            builder: (context, state) => PersonDetailsPage(
              personId: state.pathParameters['personId'].toString(),
            ),
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: 'horusVision',
            builder: (context, state) => ScaffoldPage(
              child: Container(),
            ),
          ),
        ],
      ),
    ],
  );
}
